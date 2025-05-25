import { useEditor, EditorContent } from "@tiptap/react";
import StarterKit from "@tiptap/starter-kit";
import { marked } from "marked";
import DOMPurify from "dompurify";
import { useEffect } from "react";
import "@/styles/tiptap.css";

import type { EditorView } from "@tiptap/pm/view";

interface NoteEditorProps {
  content: string;
  onUpdate: (content: string, title: string) => void;
  isNewNote?: boolean;
}

export default function NoteEditor({ content, onUpdate, isNewNote = false }: NoteEditorProps) {
  const editor = useEditor({
    extensions: [StarterKit],
    content,
    editorProps: {
      attributes: {
        class: "prose prose-neutral focus:outline-none max-w-none min-h-[60vh] px-4 py-6",
      },
      handlePaste: (_view: EditorView, event: ClipboardEvent) => {
        const clipboardData = event.clipboardData;
        if (!clipboardData) return false;

        const text = clipboardData.getData("text/plain");
        if (!text) return false;

        const markdownRegex = /(\*\*[\w\s]+\*\*|__[\w\s]+__|#{1,6}\s[\w\s]+|```[\s\S]*```|\[[\w\s]+\]\(https?:\/\/[^\s]+\)|\*\s[\w\s]+|\d\.\s[\w\s]+|-\s[\w\s]+)/;

        if (markdownRegex.test(text)) {
          event.preventDefault();

          // Gestion du retour mixte de marked.parse
          const result = marked.parse(text);

          const processContent = (parsedContent: string) => {
            const html = DOMPurify.sanitize(parsedContent);
            if (editor) {
              editor.commands.deleteSelection();
              editor.commands.insertContent(html);
            }
          };

          if (result instanceof Promise) {
            result.then(processContent).catch((error: Error) => {
              console.error("Erreur lors de la conversion markdown:", error);
            });
          } else {
            processContent(result);
          }

          return true;
        }

        return false;
      }
    },
    onCreate: ({ editor }) => {
      if (isNewNote) {
        // On attend que le contenu soit chargé avant de sélectionner le titre
        setTimeout(() => {
          const titleText = "Nouvelle note";
          const from = 1;
          const to = from + titleText.length;
          editor.commands.setTextSelection({ from, to });
          editor.commands.focus();
        }, 0);
      }
    },
    onUpdate: ({ editor }) => {
      const html = editor.getHTML();

      // extraire le titre depuis le premier <h1>
      const doc = new DOMParser().parseFromString(html, "text/html");
      const rawTitle = doc.querySelector("h1")?.textContent?.trim();
      const title = rawTitle && rawTitle.length > 0 ? rawTitle : "Sans titre";

      onUpdate(html, title);
    },
  });

  // Mise à jour du contenu quand il change
  useEffect(() => {
    if (editor && content !== editor.getHTML()) {
      editor.commands.setContent(content);
    }
  }, [content, editor]);

  // Nettoyage de l'éditeur au démontage
  useEffect(() => {
    return () => {
      editor?.destroy();
    };
  }, [editor]);

  if (!editor) return <div className="loading">Chargement de l'éditeur...</div>;

  return <EditorContent editor={editor} className="tiptap-editor" />;
}
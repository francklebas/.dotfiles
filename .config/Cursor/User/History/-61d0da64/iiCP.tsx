import { useParams } from "react-router";
import { useNotesStore } from "@/stores/useNotesStore";
import NoteEditor from "@/components/NoteEditor";
import { useEffect, useRef } from "react";
import { marked } from "marked";
import DOMPurify from "dompurify";
import { getNote, saveNote } from "@/lib/indexedDB";
import { nanoid } from "nanoid";

export default function EditorPage() {
  const { noteId: paramNoteId } = useParams<{ noteId: string }>();
  const noteId = paramNoteId || nanoid();
  const note = useNotesStore((s) => s.notes.find((n) => n.id === noteId));
  const addNote = useNotesStore((s) => s.addNote);
  const updateNote = useNotesStore((s) => s.updateNote);
  const setCurrentNote = useNotesStore((s) => s.setCurrentNote);

  // Crée la note si elle n'existe pas
  const noteCreated = useRef(false);
  const isNewNote = useRef(true);

  useEffect(() => {
    const initializeNote = async () => {
      if (!note && noteId && !noteCreated.current) {
        // Vérifie d'abord si la note existe dans IndexedDB
        const existingNote = await getNote(noteId);
        
        if (existingNote) {
          // Si la note existe, on l'ajoute au store
          addNote(existingNote);
          setCurrentNote(noteId);
          isNewNote.current = false;
        } else {
          // Sinon, on crée une nouvelle note
          const initialMarkdown = "# Nouvelle note\n\n";
          const result = marked.parse(initialMarkdown);

          const createNote = async (htmlContent: string) => {
            // Sanitize HTML content before creating the note
            const sanitizedContent = DOMPurify.sanitize(htmlContent);

            const newNote = {
              id: noteId,
              title: "Nouvelle note",
              content: sanitizedContent,
              tags: [],
              updatedAt: Date.now(),
              synced: false,
            };

            // Laisser le store gérer la sauvegarde dans IndexedDB
            addNote(newNote);
            setCurrentNote(noteId);
          };

          if (result instanceof Promise) {
            // Handle async result
            result.then(createNote).catch((error) => {
              console.error("Erreur lors de la conversion markdown:", error);
              // Fallback to raw markdown if parsing fails
              createNote(initialMarkdown);
            });
          } else {
            // Handle synchronous result
            createNote(result);
          }
        }
        noteCreated.current = true;
      }
    };

    initializeNote();
  }, [note, noteId, addNote, setCurrentNote]);

  // Si la note n'existe pas encore, on attend qu'elle soit créée
  if (!noteId || !note) {
    return (
      <div className="p-4 text-sm text-muted-foreground italic">
        Chargement de la note…
      </div>
    );
  }

  return (
    <NoteEditor
      note={note}
      onUpdate={(newContent, title) => {
        const sanitizedContent = DOMPurify.sanitize(newContent);
        updateNote({
          ...note,
          content: sanitizedContent,
          title,
          updatedAt: Date.now(),
        });
      }}
    />
  );
}
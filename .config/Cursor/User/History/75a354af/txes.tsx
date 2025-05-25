import { nanoid } from "nanoid";
import { startTransition } from "react";
import { useNavigate } from "react-router";
import { SquarePen } from "lucide-react";
import { useNotesStore } from "@/stores/useNotesStore";
import { marked } from "marked";
import DOMPurify from "dompurify";

const NewNoteButton = () => {
  const navigate = useNavigate();

  const handleClick = () => {
    const id = nanoid();
    const now = Date.now();
    const initialMarkdown = "# Nouvelle note\n\n";
    const result = marked.parse(initialMarkdown);

    const createNote = (htmlContent: string) => {
      const sanitizedContent = DOMPurify.sanitize(htmlContent);

      useNotesStore.getState().addNote({
        id,
        title: "Nouvelle note",
        content: sanitizedContent,
        tags: [],
        updatedAt: now,
        synced: false,
      });

      // 👇 React garantit que tout est prêt avant de "lancer la suite"
      startTransition(() => {
        navigate(`/editor/${id}`);
      });
    };

    if (result instanceof Promise) {
      result.then(createNote).catch((error) => {
        console.error("Erreur lors de la conversion markdown:", error);
        createNote(initialMarkdown);
      });
    } else {
      createNote(result);
    }
  };

  return (
    <button onClick={handleClick}>
      <SquarePen className="w-5 h-5" />
    </button>
  );
};

export default NewNoteButton;

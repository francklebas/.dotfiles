import { create } from "zustand";
import { devtools } from "zustand/middleware";
import { initDB, saveNote, getAllNotes, deleteNote as deleteNoteFromDB } from "../lib/indexedDB";

export interface Note {
  id: string;
  title: string;
  content: string;
  tags: string[];
  updatedAt: number;
  synced: boolean;
}

interface NotesStore {
  notes: Note[];
  currentNoteId: string | null;
  setNotes: (notes: Note[]) => void;
  addNote: (note: Note) => void;
  updateNote: (note: Note) => void;
  deleteNote: (id: string) => void;
  setCurrentNote: (id: string | null) => void;
  loadNotes: () => Promise<void>;
}

export const useNotesStore = create<NotesStore>()(
  devtools((set, get) => ({
    notes: [],
    currentNoteId: null,
    setNotes: (notes) => set({ notes }, false, "setNotes"),
    addNote: async (note) => {
      console.log('Adding note to store:', note.id);
      set((state) => ({ notes: [...state.notes, note] }), false, "addNote");
      try {
        await saveNote(note);
        console.log('Note saved to IndexedDB:', note.id);
      } catch (error) {
        console.error('Error saving note to IndexedDB:', error);
      }
    },
    updateNote: async (note) => {
      set(
        (state) => ({
          notes: state.notes.map((n) => (n.id === note.id ? note : n)),
        }),
        false,
        "updateNote",
      );
      await saveNote(note);
    },
    deleteNote: async (id) => {
      set(
        (state) => ({
          notes: state.notes.filter((n) => n.id !== id),
        }),
        false,
        "deleteNote",
      );
      await deleteNoteFromDB(id);
    },
    setCurrentNote: (id) => set({ currentNoteId: id }, false, "setCurrentNote"),
    loadNotes: async () => {
      await initDB();
      const notes = await getAllNotes();
      set({ notes }, false, "loadNotes");
    },
  })),
);

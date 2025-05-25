import { create } from 'zustand';

interface Note {
  id: string;
  content: string;
}

interface NotesStore {
  notes: Note[];
  currentNote: Note | null;
  isSync: boolean;
  syncStatus: 'idle' | 'syncing' | 'error';
  createNote: (note: Note) => void;
  updateNote: (id: string, content: string) => void;
}

const useNotesStore = create<NotesStore>((set: any) => ({
  notes: [],
  currentNote: null,
  isSync: false,
  syncStatus: 'idle',
  createNote: (note: Note) => set((state: NotesStore) => ({ notes: [...state.notes, note] })),
  updateNote: (id: string, content: string) => set((state: NotesStore) => ({
    notes: state.notes.map((note: Note) =>
      note.id === id ? { ...note, content } : note
    ),
  })),
}));

export default useNotesStore; 
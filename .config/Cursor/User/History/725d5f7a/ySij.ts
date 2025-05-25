import create from 'zustand';

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

const useNotesStore = create<NotesStore>((set) => ({
  notes: [],
  currentNote: null,
  isSync: false,
  syncStatus: 'idle',
  createNote: (note) => set((state) => ({ notes: [...state.notes, note] })),
  updateNote: (id, content) => set((state) => ({
    notes: state.notes.map((note) =>
      note.id === id ? { ...note, content } : note
    ),
  })),
}));

export default useNotesStore; 
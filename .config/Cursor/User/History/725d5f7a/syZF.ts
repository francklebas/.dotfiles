import { useEffect } from 'react';
import { create } from 'zustand';
import { openDB } from 'idb';

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

const dbPromise = openDB('chatnotes-db', 1, {
  upgrade(db) {
    db.createObjectStore('notes', { keyPath: 'id' });
  },
});

const saveNoteToDB = async (note: Note) => {
  const db = await dbPromise;
  await db.put('notes', note);
};

const loadNotesFromDB = async (): Promise<Note[]> => {
  const db = await dbPromise;
  return await db.getAll('notes');
};

const useNotesStore = create<NotesStore>((set) => ({
  notes: [],
  currentNote: null,
  isSync: false,
  syncStatus: 'idle',
  createNote: async (note) => {
    set((state) => ({ notes: [...state.notes, note] }));
    await saveNoteToDB(note);
  },
  updateNote: async (id, content) => {
    set((state) => ({
      notes: state.notes.map((note) =>
        note.id === id ? { ...note, content } : note
      ),
    }));
    const updatedNote = { id, content };
    await saveNoteToDB(updatedNote);
  },
}));

// Load notes from IndexedDB when the store is initialized
useEffect(() => {
  (async () => {
    const notes = await loadNotesFromDB();
    useNotesStore.setState({ notes });
  })();
}, []);

export default useNotesStore; 
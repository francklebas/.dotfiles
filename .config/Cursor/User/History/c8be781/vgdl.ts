import 'isomorphic-fetch';
import { Note } from '../stores/useNotesStore';

const DB_NAME = 'chadnotes';
const STORE_NAME = 'notes';
const DB_VERSION = 1;

let db: IDBDatabase | null = null;
let dbInitialized = false;

export const initDB = (): Promise<void> => {
  if (dbInitialized && db) {
    return Promise.resolve();
  }

  return new Promise((resolve, reject) => {
    const request = indexedDB.open(DB_NAME, DB_VERSION);

    request.onerror = () => {
      console.error('Error opening database:', request.error);
      reject(request.error);
    };

    request.onsuccess = () => {
      console.log('Database opened successfully');
      db = request.result;
      dbInitialized = true;
      resolve();
    };

    request.onupgradeneeded = (event) => {
      console.log('Database upgrade needed');
      const db = (event.target as IDBOpenDBRequest).result;
      
      // Supprimer l'ancien store s'il existe
      if (db.objectStoreNames.contains(STORE_NAME)) {
        db.deleteObjectStore(STORE_NAME);
      }
      
      // Créer le nouveau store
      console.log('Creating object store');
      const store = db.createObjectStore(STORE_NAME, { keyPath: 'id' });
      console.log('Object store created successfully');
    };
  });
};

export const saveNote = async (note: Note): Promise<void> => {
  if (!dbInitialized || !db) {
    console.log('Database not initialized, initializing...');
    await initDB();
  }

  return new Promise((resolve, reject) => {
    const transaction = db!.transaction(STORE_NAME, 'readwrite');
    const store = transaction.objectStore(STORE_NAME);
    const request = store.put(note);

    request.onsuccess = () => {
      console.log('Note saved successfully:', note.id);
      resolve();
    };
    request.onerror = () => {
      console.error('Error saving note:', request.error);
      reject(request.error);
    };
  });
};

export const getNote = async (id: string): Promise<Note | null> => {
  if (!db) {
    await initDB();
  }

  return new Promise((resolve, reject) => {
    const transaction = db!.transaction(STORE_NAME, 'readonly');
    const store = transaction.objectStore(STORE_NAME);
    const request = store.get(id);

    request.onsuccess = () => resolve(request.result || null);
    request.onerror = () => reject(request.error);
  });
};

export const getAllNotes = async (): Promise<Note[]> => {
  if (!db) {
    await initDB();
  }

  return new Promise((resolve, reject) => {
    const transaction = db!.transaction(STORE_NAME, 'readonly');
    const store = transaction.objectStore(STORE_NAME);
    const request = store.getAll();

    request.onsuccess = () => resolve(request.result);
    request.onerror = () => reject(request.error);
  });
};

export const deleteNote = async (id: string): Promise<void> => {
  if (!db) {
    await initDB();
  }

  return new Promise((resolve, reject) => {
    const transaction = db!.transaction(STORE_NAME, 'readwrite');
    const store = transaction.objectStore(STORE_NAME);
    const request = store.delete(id);

    request.onsuccess = () => resolve();
    request.onerror = () => reject(request.error);
  });
}; 
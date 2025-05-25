import { Routes, Route } from "react-router";
import { routes } from "@/routes";
import Layout from "./components/Layout";
import { useEffect } from "react";
import { useNotesStore } from "./stores/useNotesStore";

function App() {
  const loadNotes = useNotesStore((state) => state.loadNotes);

  useEffect(() => {
    loadNotes();
  }, [loadNotes]);

  return (
    <Layout>
      <Routes>
        {routes.map(({ path, element }) => (
          <Route key={path} path={path} element={element} />
        ))}
      </Routes>
    </Layout>
  );
}

export default App;

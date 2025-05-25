import { Link } from "react-router";
import { routes } from "@/routes";
import { useNotesStore } from "@/stores/useNotesStore";

const Sidebar = () => {
  const notes = useNotesStore((state) => state.notes);

  function getTitleFromContent(content: string): string {
    if (!content) return "Sans titre";

    const doc = new DOMParser().parseFromString(content, "text/html");
    const h1 = doc.querySelector("h1");
    const firstText = h1?.textContent?.trim();

    return firstText && firstText.length > 0 ? firstText : "Sans titre";
  }

  return (
    <aside className="w-100">
      <ul>
        {routes
          .filter((route) => !route.path.includes("editor"))
          .map((route) => (
            <li key={`note-${route.name}`}>
              <Link to={route.path}>{route.name}</Link>
            </li>
          ))}
        {notes.map((note) => (
          <li key={`note-init-${note.id}`}>
            <Link to={`/editor/${note.id}`}>{getTitleFromContent(note.content)}</Link>
          </li>
        ))}
      </ul>
    </aside>
  );
};

export default Sidebar;

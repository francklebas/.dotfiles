import React, { useEffect, useRef } from 'react';
import { EditorState } from '@codemirror/state';
import { EditorView } from '@codemirror/view';
import { basicSetup } from '@codemirror/basic-setup';
import { markdown } from '@codemirror/lang-markdown';

const MarkdownEditor: React.FC = () => {
  const editorRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    if (editorRef.current) {
      const startState = EditorState.create({
        doc: '',
        extensions: [basicSetup, markdown()]
      });

      const view = new EditorView({
        state: startState,
        parent: editorRef.current
      });

      return () => {
        view.destroy();
      };
    }
  }, []);

  return <div ref={editorRef} className="border p-4" />;
};

export default MarkdownEditor; 
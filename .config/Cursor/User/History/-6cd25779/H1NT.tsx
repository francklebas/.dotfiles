import React from 'react';
import Layout from './components/Layout';
import MarkdownEditor from './components/MarkdownEditor';

const App: React.FC = () => {
  return (
    <Layout>
      <MarkdownEditor />
    </Layout>
  );
};

export default App;

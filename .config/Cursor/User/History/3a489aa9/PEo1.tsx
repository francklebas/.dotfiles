import React from 'react';

const Layout: React.FC = ({ children }) => {
  return (
    <div className="min-h-screen flex flex-col">
      <header className="bg-gray-800 text-white p-4">
        <h1 className="text-xl">ChatNotes</h1>
      </header>
      <main className="flex-grow p-4">
        {children}
      </main>
    </div>
  );
};

export default Layout; 
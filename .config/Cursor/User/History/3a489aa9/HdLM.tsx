import React, { ReactNode } from 'react';

interface LayoutProps {
  children: ReactNode;
}

const Layout: React.FC<LayoutProps> = ({ children }) => {
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
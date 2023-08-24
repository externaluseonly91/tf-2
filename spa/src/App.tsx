import React from "react";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import UploadPage from "./pages/UploadPage";
import HomePage from "./pages/HomePage";

import "./App.css";

function App() {
  return (
    <div className="app">
      <header className="app-header">
        <h1>Video Library</h1>
      </header>

      <div className="container-md">

        <div className="row app-content">
          <div className="col">
            <BrowserRouter>
              <Routes>
                <Route path="/upload" element={<UploadPage />} />
                <Route path="/" element={<HomePage />} />
              </Routes>
            </BrowserRouter>
          </div>
        </div>

      </div>
    </div>
  );
}

export default App;

import React from "react";
import { Link } from "react-router-dom";
import VideoForm from "../components/VideoForm";

const UploadPage = () => {

  return (
    <div className="upload-page">

      <nav className="navbar bg-light app-navbar">
        <div className="container-fluid">
          <a className="navbar-brand h2">Upload Video</a>
          <Link to={`/`} className="nav-link">
            <button className="btn btn-outline-secondary">Back</button>
          </Link>
        </div>
      </nav>

      <VideoForm />
    </div>
  );
};

export default UploadPage;

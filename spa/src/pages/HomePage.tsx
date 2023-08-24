import React from "react";
import { Link } from "react-router-dom";
import VideoList from "../components/VideoList";

const HomePage = () => {

  return (
    <div className="home-page">

      <nav className="navbar bg-light app-navbar">
        <div className="container-fluid">
          <a className="navbar-brand h2">Videos</a>
          <Link to={`/upload`} className="nav-link">
            <button className="btn btn-outline-primary">Upload</button>
          </Link>
        </div>
      </nav>

      <VideoList />
    </div>
  );
};

export default HomePage;

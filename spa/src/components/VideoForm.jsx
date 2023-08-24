import React, {useState, useEffect} from 'react';
import {listCategories, createVideo} from "../services/API";

import "./VideoForm.css";

const VideoForm = props => {
  const [message, setMessage] = useState("");
  const [categories, setCategories] = useState([]);

  const [title, setTitle] = useState("");
  const [categoryId, setCategoryId] = useState("");

  useEffect(() => {
    listCategories()
      .then(items => { setCategories(items) })
  }, [])

  const submitForm = (event) => {
    event.preventDefault();

    const formData = new FormData(event.target);

    createVideo(formData)
      .then(data => {
        setMessage("Video successfully uploaded");
        setTitle("");
        event.target.file.value = null;
        setCategoryId("");
      })
      .catch(errorMessage => {
        setMessage(`Failed to upload video: ${errorMessage}`);
      });
  }

  return (
    <form className="video-form" onSubmit={submitForm}>
      {
        message &&
        <div className="alert alert-secondary" role="alert">
          {message}
        </div>
      }

      <div className="mb-3">
        <label htmlFor="title" className="form-label">
          Title
        </label>
        <input
          id="title"
          type="text"
          name="title" 
          value={title}
          onChange={(e) => setTitle(e.target.value)}
          onBlur={(e) => setTitle(e.target.value)}
          required
          className="form-control"
        />
      </div>

      <div className="mb-3">
        <label htmlFor="file" className="form-label">
          File
        </label>
        <input
          id="file"
          type="file"
          name="file"
          accept="video/mp4, video/mov"
          required
          className="form-control"
        />
      </div>


      <div className="mb-3">
        <label htmlFor="category" className="form-label">
          Category
        </label>
        <select
          id="category"
          name="category_id"
          value={categoryId}
          onChange={e => setCategoryId(e.target.value)}
          onBlur={e => setCategoryId(e.target.value)}
          required
          className="form-select"
        >
          <option />
          {categories.map(category => (
            <option key={category.id} value={category.id}>
              {category.name}
            </option>
          ))}
        </select>
      </div>

      <input type="submit" value="Submit" className="btn btn-primary"/>
    </form>
  );
  
}

export default VideoForm;
import React, { useState, useEffect } from "react";
import Video from "../components/Video";
import { listVideos } from "../services/API";

const VideoList = () => {
  const [videos, setVideos] = useState([]);

  useEffect(() => {
    listVideos()
      .then(data => {
        setVideos(data)
      });
  }, []);

  return (
    <div className="video-list">
      {!videos.length ? (
        <p>No videos uploaded yet!</p>
      ) : (
        videos.map((video) => (
          <Video
            key={video.id}
            title={video.title}
            url={video.file.url}
            thumbnail={video.file.thumbnails.large}
          />
        ))
      )}
    </div>
  );
};

export default VideoList;

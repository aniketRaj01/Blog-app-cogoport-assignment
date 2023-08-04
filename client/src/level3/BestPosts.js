import React, { useState, useEffect } from "react";

// Assuming we have a posts array with post objects having 'likes' and 'datetime' properties
const posts = [
  {
    id: 1,
    title: "Post 1",
    likes: 100,
    datetime: new Date("2023-08-01T12:00:00").toISOString(),
  },
  {
    id: 2,
    title: "Post 2",
    likes: 200,
    datetime: new Date("2023-08-02T12:00:00").toISOString(),
  },
  {
    id: 3,
    title: "Post 3",
    likes: 50,
    datetime: new Date("2023-08-03T12:00:00").toISOString(),
  },
  // Add more post objects as needed
];

const BestPosts = () => {
  const [bestPosts, setbestPosts] = useState([]);

  useEffect(() => {
    // Calculate the average likes per unit time for each post
    const now = new Date(); // You can adjust the unit time as needed (e.g., 24 hours, 7 days, etc.)

    const postsWithAvgLikes = posts.map((post) => {
      const datetime = new Date(post.datetime);
      const timeDifferenceInHours = (now - datetime) ;
      const avgLikes = post.likes / (timeDifferenceInHours );
      return { ...post, avgLikes };
    });

    // Sort the posts based on the average likes per unit time in descending order
    postsWithAvgLikes.sort((a, b) => b.avgLikes - a.avgLikes);

    // Set the best posts based on the sorted array
    setbestPosts(postsWithAvgLikes.slice(0,2));
  }, []);

  return (
    <div>
      <h2>best Posts</h2>
      {bestPosts.map((post) => (
        <div key={post.id}>
          <h3>{post.title}</h3>
          <p>Likes: {post.likes}</p>
          {/* Display other post details as needed */}
        </div>
      ))}
    </div>
  );
};

export default BestPosts;

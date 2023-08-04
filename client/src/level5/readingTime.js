const readingTime = (content) => {
    const averageReadingSpeed=60;
    const wordsPerMinute = content.split(" ").length / averageReadingSpeed;
    return Math.ceil(wordsPerMinute);
  };

export default readingTime;
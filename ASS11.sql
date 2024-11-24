db.createCollection("Books")

Insert sample data into the "Books" collection

db.Books.insertMany([
  {
    TITLE: "Book 1",
    DESCRIPTION: "Description 1",
    BY: "John",
    URL: "url1",
    TAGS: ["tag1", "tag2"],
    LIKES: 10
  },
  {
    TITLE: "Book 2",
    DESCRIPTION: "Description 2",
    BY: "John",
    URL: "url2",
    TAGS: ["tag1", "tag3"],
    LIKES: 5
  },
  {
    TITLE: "Book 3",
    DESCRIPTION: "Description 3",
    BY: "Alice",
    URL: "url3",
    TAGS: ["tag2", "tag3"],
    LIKES: 20
  },
  {
    TITLE: "Book 4",
    DESCRIPTION: "Description 4",
    BY: "John",
    URL: "url4",
    TAGS: ["tag1", "tag4"],
    LIKES: 15
  }
])

Find the number of books published by John:

db.Books.aggregate([
  {
    $match: { BY: "John" }
  },
  {
    $group: {
      _id: null,
      count: { $sum: 1 }
    }
  }
])

Find books which have the minimum and maximum likes published by John:

db.Books.aggregate([
  {
    $match: { BY: "John" }
  },
  {
    $group: {
      _id: null,
      minLikes: { $min: "$LIKES" },
      maxLikes: { $max: "$LIKES" }
    }
  }
])


Find the average number of likes of the books published by John:

db.Books.aggregate([
  {
    $match: { BY: "John" }
  },
  {
    $group: {
      _id: null,
      avgLikes: { $avg: "$LIKES" }
    }
  }
])


Find the first and last book published by John:

db.Books.find({ BY: "John" }).sort({ _id: 1 }).limit(1)
db.Books.find({ BY: "John" }).sort({ _id: -1 }).limit(1)


Create an index on the "BY" field (author name):

db.Books.createIndex({ BY: 1 })


Display the books published by John and check if it uses the index:

db.Books.find({ BY: "John" }).explain("executionStats")
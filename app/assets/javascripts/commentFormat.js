function CommentFormat(){
  this.commentId;
  this.commentUser;
  this.commentContent;
}

CommentFormat.prototype.setData = function(data){
  this.commentId = data["comment"]["id"];
  this.commentUser = data["comment"]["user"]
  this.commentContent = data["comment"]["content"];
}
CommentFormat.prototype.commentHtml = function(){
  var injectText = '<div id = "comment-' + this.commentId + '">';
      injectText +='<h3> ' + this.commentUser["name"] + " Says: </h3>";
      injectText +='<div id = "editDiv"><h4> ' + this.commentContent + " </h4></div>";
      injectText +='<a href = "#" class = "btn editLink" data-id = "' + this.commentId + '" data-user-id="' + this.commentUser["id"] + '">Edit Comment</a>';
      injectText +='<a href = "#" class = "btn deleteLink" data-id = "' + this.commentId + '" data-user-id="' + this.commentUser["id"] + '">Delete Comment</a></div>';
  return injectText;
}

CommentFormat.prototype.editHtml = function(){
  var injectText = '<form data-id = "' + this.commentId + '" class = "editComment" method = "post" action = "/comments/' + this.commentId + '">';
      injectText += '<textarea rows="8" cols="50" name="comment[content]" id = "comment_content">' + this.commentContent + '</textarea><br>';
      injectText += '<button>Submit</button><br><br>';
      injectText += '</form>';
  return injectText; 
}


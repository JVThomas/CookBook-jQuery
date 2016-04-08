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
      injectText +='<h4> ' + this.commentContent + " </h4>";
      injectText +='<a href = "/users/' + this.commentUser["id"] +'/comments/'+ this.commentId+'/edit" class = "btn">Edit Comment</a>';
      injectText +='<a href = "#" class = "btn deleteLink" data-id = "' + this.commentId + '" data-user-id="' + this.commentUser["id"] + '">Delete Comment</a></div>';
  return injectText;
}


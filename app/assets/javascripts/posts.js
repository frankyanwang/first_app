// global NAMESPACE SWAP_GURU
var SWAP_GURU = SWAP_GURU || {};
SWAP_GURU.posts = SWAP_GURU.posts || {};

(function($){
	var $dialog;
	var post_id, trade_post_id;
	var ITEM_PER_PAGE = 2;
	var page_offset = ITEM_PER_PAGE;
	
	function create_dialog_myposts(){
		$dialog = $('<div></div>')
		.html('This dialog will show every time!')
		.dialog({
				modal: true,
				autoOpen: false,
				title: 'Your Current Available Posts',
				position: 'center',
				width: 760,
				height: 530
			});
		
		$('.open_dialog').live('click', function() {
	        post_id = $(this).attr('post_id');
			$.get(
	            "/posts/my_posts", 
	            {},
	            function (data) {
	                $dialog.empty().append(data);
					$dialog.dialog('open');
	            }
	        );
			// prevent the default action, e.g., following a link
			return false;
		});					
	}
	
	function ajax_get_and_alter_proposal_form(element){
		$.get('/proposals/new', function(data){
			element.append(data);
			element.find('input#proposal_post_id').attr('value', post_id);
			element.find('input#proposal_trade_post_id').attr('value', trade_post_id);			
		});
	}
	
	function load_more_posts(){
		
		$.get('/feed_timeline', {layout: "false", offset: page_offset}, function(data){
			$('#time_line_post').append(data);
			page_offset += ITEM_PER_PAGE;
		});
	}
	
	function create_loading_div(){
		loading_div = $("<div id='loading_div' style='display:none'>Loading ..... </div>");
		$('#container').append(loading_div);
		
	 	$('#loading_div').ajaxSend(function() {
	        $(this).show();
	    }).ajaxStop(function() {
	        $(this).hide();
	    });		
	}
	
	// register live event -----------------
	$('.propose').live('click', function(){
		trade_post_id = $(this).attr('trade_post_id');
		//$('#my_posts').empty(); //.append(post_id).append("---").append(trade_post_id);
		ajax_get_and_alter_proposal_form($('#my_posts').empty());
	});
	
	// initialize variables/elements not depends on DOM.
	
	// Initialization depending when DOM ready.		
	$(document).ready(function(){
		
		create_dialog_myposts();
		
		create_loading_div();
		$('#load_more').live('click', function(){
			$(this).remove();
			load_more_posts();
		});
		
	});

})(jQuery, SWAP_GURU.posts);

// Facebook like function
(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) {return;}
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_US/all.js#xfbml=1";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));
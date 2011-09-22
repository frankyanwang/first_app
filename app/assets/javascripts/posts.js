// global NAMESPACE SWAP_GURU
var SWAP_GURU = SWAP_GURU || {};
SWAP_GURU.posts = SWAP_GURU.posts || {};

(function($){
	var $dialog;
	var post_id, trade_post_id;
	
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
		
		$('.open_dialog').click(function() {
	        post_id = $(this).attr('post_id');
			$dialog.load(
	            "/myposts", 
	            {},
	            function (responseText, textStatus, XMLHttpRequest) {
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
	});

})(jQuery, SWAP_GURU.posts);
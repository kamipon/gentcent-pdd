<script type="text/javascript">
$(document).ready(function(){
  	var message=$("#message").val();
  	if(message!=null&&message!=""){
  		alert(message);
  	}
});
</script>
<input type="hidden" value="${message }" id="message"/>
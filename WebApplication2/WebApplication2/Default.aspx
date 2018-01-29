<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebApplication2._Default" EnableEventValidation="false"  ValidateRequest="False" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Registration Page</title>
     <script type="text/javascript"  src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js""></script>
   <script type="text/javascript">
          
        $(function select()  {
         $.ajax({
              type: "POST",
              url: "Default.aspx/GetCountry",
              data:'{}',
              contentType: "application/json; charset=utf-8", 
              dataType: "json",
              success:function select(r) {
               var ddlCountry = $("[id*=ddlCountry]");
               //ddlCountry.empty().append('<option selected="selected" value="0">Please select</option>');
              $.each(r.d, function select() {
                  ddlCountry.append($("<option></option>").val(this['Value']).html(this['Text']));
                   });  },
            error: function select(r) { }
             });
           });
           
        function Reset() {
    
            document.getElementById("txtboxname").value = "";
            document.getElementById("txtboxic").value = "";
            document.getElementById("txtboxdob").value = "";
            document.getElementById("ddlGender").value = 1;
         }
          
     
           
        
          function Exit() {
           // alert("This is not a valid Ic number");
          var ic =  document.getElementById("txtboxic").value 
            var regex = new RegExp(/^\d{6}-?\d{2}-?\d{4}$/);
              if(regex.test(ic)){
              
              var year = ic.substring(0,2)
              var month = ic.substring(2,4)
              var date = ic.substring(4,6)
              
               
              if (year < 30)
              {
              var concatyear = "20";
               year = concatyear.concat(year);
            
               }
             var y = new Date(year);
             var finyear = y.getFullYear();
             var concatd = date.concat("-",month,"-",finyear)
           
              
            document.getElementById("txtboxdob").value = concatd;
              
             return true;
                 }
              else{
              alert("This is not a valid IC number");
               return false;
                  }
          }
    
       
         function SubmitData()  {
         $.ajax({
              type: "POST",
              url: "Default.aspx/SubmitData",
              data:'{name: "' + $("#<%=txtboxname.ClientID%>")[0].value + '" , ic: "' + $("#<%=txtboxic.ClientID%>")[0].value + '" ,dob: "' + $("#<%=txtboxdob.ClientID%>")[0].value + '" ,gender: "' + $("#<%=ddlGender.ClientID%>")[0].value + '",country: "' + $("#<%=ddlCountry.ClientID%>")[0].value + '" }',
              contentType: "application/json; charset=utf-8", 
              dataType: "json",
              success:function SubmitData(r) {
              var indicate  = 0 ;
              var name  =  document.getElementById("txtboxname").value 
              var ic    =  document.getElementById("txtboxic").value 
              var gender  =  document.getElementById("ddlGender").value 
              var country  =  document.getElementById("ddlCountry").value 
            
              if (name == "")
              {
                alert("Please enter your name ?");
                indicate = indicate - 1 ;
              }
              else { indicate = indicate  + 1 ;}
              
              if (ic == "")
              {
                alert("Please enter your IC number ?");
                indicate = indicate - 1 ;
              }
              else { indicate = indicate + 1 ;}
              
              if (gender == "1")
              {
                alert("Please select your gender ?");
                indicate = indicate - 1 ;
              }
              else { indicate = indicate + 1 ;}
              
              if (country == "0")
              {
                alert("Please select your country ?");
                indicate = indicate - 1 ;
              }
              else { indicate = indicate + 1;}
              
              if (indicate > 3)
              {
            alert("Registration Completed");
            document.getElementById("txtboxname").value = "";
            document.getElementById("txtboxic").value = "";
            document.getElementById("txtboxdob").value = "";
            document.getElementById("ddlGender").value = 1;
            document.getElementById("ddlCountry").value = 0;
            }
                 
                  },
            failure: function SubmitData(r) {
             
             }
             });
           };
       
       
</script>

</head>
<body>
    <form id="form1" runat="server" >
    
    <div style="margin-left: 40px; width: 413px;">
 
    Name: &nbsp;
     <asp:TextBox ID="txtboxname" runat="server" Width="130px" AutoPostBack="True"  ></asp:TextBox><br />
     <br />
    IC No: &nbsp;
     <asp:TextBox ID="txtboxic" runat="server" Width="117px"   OnBlur="Exit()"   ></asp:TextBox><br />
     <br />
    DOB: &nbsp;
     <asp:TextBox ID="txtboxdob" runat="server" Enabled ="false" ></asp:TextBox><br /><br />
    Gender: &nbsp;
    <asp:DropDownList ID = "ddlGender" runat="server">
      <asp:ListItem Enabled="true" Text=" Please select Gender" Value="1"></asp:ListItem>
      <asp:ListItem Enabled="true" Text="Male" Value="Male"></asp:ListItem>
      <asp:ListItem Enabled="true" Text="Female" Value="Female"></asp:ListItem>
   </asp:DropDownList> <br /><br />
     Country: &nbsp;
    <asp:DropDownList ID = "ddlCountry" runat="server" >
     <asp:ListItem Enabled="true" Text="Please select country" Value="0" Selected="True"></asp:ListItem>
   
    </asp:DropDownList>
     
     <br /><br />
      
     <input  type ="button" ID="btnsubmit" runat="server" value="Submit" onclick="SubmitData()"  />	&nbsp;	&nbsp;	&nbsp;
     <asp:Button ID="btnreset" runat="server" Text="Reset" OnClientClick="Reset()" />
    
        
    </div>

      
    </form>
</body>
</html>


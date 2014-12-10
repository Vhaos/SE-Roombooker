<%@ page import="utils.DBAdapter" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Conne  ction" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="org.apache.commons.codec.digest.DigestUtils" %>
<%@ page import="utils.LoginSystem" %>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- meta data required for opengraph sites-->
    <meta property="og:title" content="Nameless organisation - Room booking service" >
    <meta property="og:type" content="website" >
    <meta property="og:site_name" content="Book A Room service" >
    <meta property="og:image:width" content="200" >
    <meta property="og:image:height" content="200" >
    <!-- <meta property="og:url" content="http://bookaroom.com" > -->
    <meta property="og:description" content="Welcome to the Nameless organisation book a room online service. From here you may enter your critieria to select a soecific room or simply browse all our rooms.">

    <!-- meta data required for Twitter -->
    <meta name="twitter:site" content="@bookarooom" >
    <meta name="twitter:title" content="Book A Room service" >
    <meta name="twitter:card" content="Welcome to the Nameless organisation room booking service!" >
    <meta name="twitter:description" content="Welcome to the Nameless organisation book a room online service. From here you may enter your critieria to select a soecific room or simply browse all our rooms." >
    <!-- <meta name="twitter:url" content="http://www.bookaroom.com" > -->

    <title>Room Booking</title>


    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/plugins/metisMenu/metisMenu.min.css" rel="stylesheet">
    <link href="css/plugins/timeline.css" rel="stylesheet">
    <link href="css/main.css" rel="stylesheet">
    <link href="css/plugins/morris.css" rel="stylesheet">
    <link href="font-awesome-4.1.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>

<body>

<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    ArrayList<Object> list = new ArrayList<Object>();
    list.add(username);
    if(username!=null && password !=null && !username.equals("") && !password.equals("")) {
        Connection cxn = null;
        try {
            cxn = DBAdapter.dbConnect();
            ResultSet rs = DBAdapter.dbExecute("SELECT username, password FROM users WHERE username=?", list, false, cxn);
            if(rs.next()) {
                boolean success = password.equals(rs.getString("password"));
                if (success) {
                    LoginSystem.saveSession(session, request, response, username);
                } else {
                    out.println("Invalid Password");
                }
            } else out.println("Invalid Username");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if(cxn!=null) try{cxn.close();} catch(SQLException e) {e.printStackTrace();}
        }
    }
%>

    <div id="wrapper">

        <!-- Navigation -->
        <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
            <ul class="nav navbar-top-links navbar-left">
                <!-- /.dropdown -->
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                        <i class="fa fa-list fa-fw"></i>  <i class="fa fa-caret-down"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-alerts">
                        <li>
                            <a href="tables.html"><i class="fa fa-user fa-fw"></i> Contact</a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="tables.html"><i class="fa fa-flag fa-fw"></i> Help</a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="tables.html"><i class="fa fa-font fa-fw"></i> About</a>
                        </li>
                    </ul>
                    <!-- /.dropdown-alerts -->
                </li>
                <!-- /.dropdown -->
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                        <i class="fa fa-bell fa-fw"></i>  <i class="fa fa-caret-down"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-alerts">
                        <li>
                            <a href="#">
                                <div>
                                    <i class="fa fa-envelope fa-fw"></i>System message: Welcome to Nameless Organisation's book a room service!
                                    <span class="pull-right text-muted small">4 minutes ago</span>
                                </div>
                            </a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="#">
                                <div>
                                    <i class="fa fa-upload fa-fw"></i> Server Rebooted
                                    <span class="pull-right text-muted small">4 minutes ago</span>
                                </div>
                            </a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a class="text-center" href="#">
                                <strong>See All System Messages</strong>
                                <i class="fa fa-angle-right"></i>
                            </a>
                        </li>
                    </ul>
                    <!-- /.dropdown-alerts -->
                </li>
            </ul>

            <div class="navbar-header">
                <a class="navbar-brand" href="index.html"><i class="fa fa-home fa-fw"></i></a>
            </div>
            <!-- /.navbar-header -->

            <ul class="nav navbar-top-links navbar-right"> 
                <button class="btn btn-primary" data-toggle="modal" data-target="#loginModal">
                    Login
                </button>
                <!-- /.dropdown -->
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                        <i class="fa fa-user fa-fw"></i>  <i class="fa fa-caret-down"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-user">
                        <li><a href="#"><i class="fa fa-user fa-fw"></i> User Profile</a>
                        </li>
                        <li><a href="#"><i class="fa fa-gear fa-fw"></i> Settings</a>
                        </li>
                        <li class="divider"></li>
                        <li><a href="login.html"><i class="fa fa-sign-out fa-fw"></i> Logout</a>
                        </li>
                    </ul>
                    <!-- /.dropdown-user -->
                </li>
                <!-- /.dropdown -->
            </ul>
            <!-- /.navbar-top-links -->
        </nav>

        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12" style="text-align: center">
                    <h1 class="page-header" style="padding-bottom: 5em; font-size: 47px; color: #999; font-weight: bold; font-family: Calibri; margin: 40px 90px 20px; ">Book A Room</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row" style="padding: 0 0em;">
                <div class=" col-md-4" style="padding: 0 8em;">
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-xs-3">
                                    <i class="fa fa-search fa-5x"></i>
                                </div>
                                <div class="col-xs-9 text-center">
                                    <div>Search for the room thats right for you</div>
                                </div>
                            </div>
                        </div>
                        <a href="search.html">
                            <div class="panel-footer">
                                <span class="pull-left">Search</span>
                                <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                <div class="clearfix"></div>
                            </div>
                        </a>
                    </div>
                </div>
                <div class="col-md-4" style="padding: 0 8em;">
                    <div class="panel panel-green">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-xs-3">
                                    <i class="fa fa-book fa-5x"></i>
                                </div>
                                <div class="col-xs-9 text-center">
                                    <div>Browse through the rooms you've booked</div>
                                </div>
                            </div>
                        </div>
                        <a href="bookings.html">
                            <div class="panel-footer">
                                <span class="pull-left">My Bookings</span>
                                <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                <div class="clearfix"></div>
                            </div>
                        </a>
                    </div>
                </div>
                <div class="col-md-4"style="padding: 0 8em;">
                    <div class="panel panel-yellow">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-xs-3">
                                    <i class="fa fa-dashboard fa-5x"></i>
                                </div>
                                <div class="col-xs-9 text-center">
                                    <div>Browse the rooms free right now!</div>
                                </div>
                            </div>
                        </div>
                        <a href="available.html">
                            <div class="panel-footer">
                                <span class="pull-left">Available Now</span>
                                <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                <div class="clearfix"></div>
                            </div>
                        </a>
                    </div>
                </div>
            </div>

            <!-- Modal -->
                <div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <div class="panel-heading">
                                    <h2 class="panel-title">Please Sign In</h3>
                                </div>
                            </div>
                            <div class="modal-body">
                                <form role="form">
                                    <fieldset>
                                        <div class="form-group">
                                            <input class="form-control" placeholder="E-mail" name="username" type="email" autofocus>
                                        </div>
                                        <div class="form-group">
                                            <input class="form-control" placeholder="Password" name="password" type="password" value="">
                                        </div>
                                        <div class="checkbox">
                                            <label>
                                                <input name="remember" type="checkbox" value="Remember Me">Remember Me
                                            </label>
                                        </div>
                                        <!-- Change this to a button or input when using this as a form -->
                                        <button type="submit" class="btn btn-success btn-block">Login</button>
                                    </fieldset>
                                </form>
                            </div>
                            <div class="modal-footer">
                                <p>Don't have an account? <a href="#">Sign Up</a></p>
                            </div>
                        </div>
                        <!-- /.modal-content -->
                    </div>
                    <!-- /.modal-dialog -->
                </div>
            <!-- /.modal -->

            <footer class="bs-docs-footer" role="contentinfo">
              <div class="container">
                <p style="margin: 0 0 2px;">Copyright © 2013 UCL (University College London). All rights reserved.</p>
                
                <p style="margin: 0 0 2px;">Maintained by Group 5(?), Software engineering team. Built with Bootstrap, Jquery, and java back-end</p>
                
                <p style="margin: 0 0 2px;">University College London - Gower Street - London - WC1E 6BT</p>
              </div>
            </footer>
        </div>
        <!-- /#page-wrapper -->
    </div>
    <!-- /#wrapper -->

    <!-- jQuery -->
    <script src="js/jquery.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>

    <!-- Metis Menu Plugin JavaScript -->
    <script src="js/plugins/metisMenu/metisMenu.min.js"></script>

    <!-- Morris Charts JavaScript -->
    <script src="js/plugins/morris/raphael.min.js"></script>
    <script src="js/plugins/morris/morris.min.js"></script>
    <script src="js/plugins/morris/morris-data.js"></script>

    <!-- Custom Theme JavaScript -->
    <script src="js/main.js"></script>

</body>

</html>

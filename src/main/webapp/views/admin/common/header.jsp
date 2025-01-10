<%@ page contentType="text/html; charset=utf-8"%>
<!-- Page Wrapper -->
    <div id="wrapper">
        <!-- Sidebar -->
        <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

            <!-- Sidebar - Brand -->
            <a class="sidebar-brand d-flex align-items-center justify-content-center" href="/views/bootstrapTheme/adminMain.jsp">
                <div class="sidebar-brand-icon rotate-n-15">
                    <i class="fas fa-laugh-wink"></i>
                </div>
                <div class="sidebar-brand-text mx-3">OTA Admin </div>
            </a>

            <!-- Divider -->
            <hr class="sidebar-divider my-0">

            <!-- Nav Item - Dashboard -->
            <li class="nav-item active">
                <a class="nav-link" href="/views/bootstrapTheme/adminMain.jsp">
                    <i class="fas fa-fw fa-tachometer-alt"></i>
                    <span>Dashboard</span></a>
            </li>

            <!-- Divider -->
            <hr class="sidebar-divider">

            <!-- Heading -->
            <div class="sidebar-heading">
                홈페이지관리
            </div>

            <!-- Nav Item - Notice Collapse Menu -->
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseNotice"
                    aria-expanded="true" aria-controls="collapseNotice">
                    <i class="fas fa-fw fa-wrench"></i>
                    <span>공지사항</span>
                </a>
                <div id="collapseNotice" class="collapse" aria-labelledby="headingNotice" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <a class="collapse-item" href="/notice/adminList">목록조회</a>
                        <a class="collapse-item" href="/notice/writeForm">글쓰기</a>
                    </div>
                </div>
            </li>
            
           
            <!-- Nav Item - User Collapse Menu -->
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseUser"
                    aria-expanded="true" aria-controls="collapseUser">
                    <i class="fas fa-fw fa-wrench"></i>
                    <span>회원 관리</span>
                </a>
                <div id="collapseUser" class="collapse" aria-labelledby="headingUser"
                    data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <a class="collapse-item" href="/userlist">회원 목록</a>
                        <a class="collapse-item" href="/admin/contactUs/adminList">1:1 문의</a>
                    </div>
                </div>
            </li>
            
            <!-- Nav Item - User Collapse Menu -->
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseAution"
                    aria-expanded="true" aria-controls="collapseAution">
                    <i class="fas fa-fw fa-wrench"></i>
                    <span>경매 관리</span>
                </a>
                <div id="collapseAution" class="collapse" aria-labelledby="headingAution"
                    data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <a class="collapse-item" href="/views/bootstrapTheme/utilities-border.html">Borders</a>
                        <a class="collapse-item" href="/views/bootstrapTheme/utilities-other.html">Other</a>
                    </div>
                </div>
            </li>

            <!-- Divider -->
            <hr class="sidebar-divider">
        
            <!-- Sidebar Message -->
            <div class="sidebar-card d-none d-lg-flex">
                <img class="sidebar-card-illustration mb-2" src="/views/bootstrapTheme/img/undraw_rocket.svg" alt="...">
                <p class="text-center mb-2"><strong>SB Admin Pro</strong> is packed with premium features, components, and more!</p>
                <a class="btn btn-success btn-sm" href="/welcome">경매 화면으로</a>
            </div>

        </ul>
        <!-- End of Sidebar --><!-- End of Sidebar --><!-- End of Sidebar --><!-- End of Sidebar --><!-- End of Sidebar -->
        <!-- End of Sidebar --><!-- End of Sidebar --><!-- End of Sidebar --><!-- End of Sidebar --><!-- End of Sidebar -->
        <!-- End of Sidebar --><!-- End of Sidebar --><!-- End of Sidebar --><!-- End of Sidebar --><!-- End of Sidebar -->

        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">
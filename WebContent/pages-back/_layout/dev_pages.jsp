<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
  <div class="d-flex flex-column flex-column-fluid">
    <div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
      <div
        id="kt_app_toolbar_container"
        class="app-container container-fluid d-flex flex-stack"
      >
        <div
          class="page-title d-flex flex-column justify-content-center flex-wrap me-3"
        >
          <h2
            class="page-heading d-flex text-gray-700 fw-semibold flex-column justify-content-center my-0"
          >
            Developing Pages
          </h2>
          <ul
            class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1"
          >
            <li class="breadcrumb-item text-muted">Home</li>
            <li class="breadcrumb-item">
              <span
                class="bullet bg-gray-500 fw-medium fs-7 w-5px h-2px"
              ></span>
            </li>
            <li class="breadcrumb-item text-muted fw-medium fs-7">
              Developing Pages
            </li>
          </ul>
        </div>
      </div>
    </div>
    <div id="kt_app_content" class="app-content flex-column-fluid">
      <div id="kt_app_content_container" class="app-container container-fluid">
        <div class="row mt-8">
          <div class="col-12">
            <div class="card">
              <div class="card-header border-0 pt-6 align-items-start">
                <div class="card-title">
                  <h3 class="page-heading d-flex text-gray-900 fw-medium my-0">
                    Product
                  </h3>
                </div>
              </div>
              <div class="card-body">
                <div class="d-flex gap-4">
                  <a
                    href="/equipment_request_list"
                    class="btn btn-light-primary d-inline-flex align-items-center px-6 py-3"
                    >MR - Material Request</a
                  >
                  <a
                    href="#"
                    class="btn btn-light-success d-inline-flex align-items-center px-6 py-3"
                    >MR - Approval</a
                  >
                  <a
                    href="purchase_requisition"
                    class="btn btn-light-warning d-inline-flex align-items-center px-6 py-3"
                    >PR - Purchase Requisition</a
                  >
                  <a
                    href="purchase_order_list"
                    class="btn btn-light-info d-inline-flex align-items-center px-6 py-3"
                    >PO - Purchase Order</a
                  >
                  <a
                    href="#"
                    class="btn btn-light-danger d-inline-flex align-items-center px-6 py-3"
                    >GR - Goods Receipt</a
                  >
                  <a
                    href="purchase_requisition_list"
                    class="btn btn-light-warning d-inline-flex align-items-center px-6 py-3"
                    >PR New - Purchase Requisition</a
                  >
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="row mt-8">
          <div class="col-12">
            <div class="card">
              <div class="card-header border-0 pt-6 align-items-start">
                <div class="card-title">
                  <h3 class="page-heading d-flex text-gray-900 fw-medium my-0">
                    Vender
                  </h3>
                </div>
              </div>
              <div class="card-body">
                <div class="d-flex gap-4">
                  <a
                    href="company_list"
                    class="btn btn-light-primary d-inline-flex align-items-center px-6 py-3"
                    >Company</a
                  >
                  <a
                    href="contact"
                    class="btn btn-light-success d-inline-flex align-items-center px-6 py-3"
                    >Contact</a
                  >
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="row mt-8">
          <div class="col-12">
            <div class="card">
              <div class="card-header border-0 pt-6 align-items-start">
                <div class="card-title">
                  <h3 class="page-heading d-flex text-gray-900 fw-medium my-0">
                    Stock
                  </h3>
                </div>
              </div>
              <div class="card-body">
                <div class="d-flex gap-4">
                  <a
                    href="stock_cons_list"
                    class="btn btn-light-warning d-inline-flex align-items-center px-6 py-3"
                    >Product</a
                  >
                  <a
                    href="stock_by_product_list"
                    class="btn btn-light-primary d-inline-flex align-items-center px-6 py-3"
                    >Stock By Product</a
                  >
                  <a
                    href="stock_by_location_list"
                    class="btn btn-light-info d-inline-flex align-items-center px-6 py-3"
                    >Stock By Location</a
                  >
                </div>
              </div>
            </div>
          </div>
        </div>

        <div class="row mt-8">
          <div class="col-12">
            <div class="card">
              <div class="card-header border-0 pt-6 align-items-start">
                <div class="card-title">
                  <h3 class="page-heading d-flex text-gray-900 fw-medium my-0">
                    Setting
                  </h3>
                </div>
              </div>
              <div class="card-body">
                <div class="d-flex gap-4">
                  <a
                    href="warehouse_list"
                    class="btn btn-light-primary d-inline-flex align-items-center px-6 py-3"
                    >Warehouse</a
                  >

                  <a
                    href="doc_status_list"
                    class="btn btn-light-success d-inline-flex align-items-center px-6 py-3"
                    >Doc Status</a
                  >
                </div>
              </div>
            </div>
          </div>
        </div>

        <div class="row mt-8">
          <div class="col-12">
            <div class="card">
              <div class="card-header border-0 pt-6 align-items-start">
                <div class="card-title">
                  <h3 class="page-heading d-flex text-gray-900 fw-medium my-0">
                    Notification
                  </h3>
                </div>
              </div>
              <div class="card-body">
                <div class="d-flex gap-4">
                  <!--begin::Notifications-->
                  <div class="position-relative">
                    <!--begin::Menu toggle-->
                    <div
                      class="btn btn-icon btn-custom btn-icon-muted btn-active-light btn-active-color-primary w-35px h-35px position-relative"
                      data-kt-menu-trigger="{default: 'click', lg: 'hover'}"
                      data-kt-menu-attach="parent"
                      data-kt-menu-placement="bottom-end"
                    >
                      <i class="ki-duotone ki-notification fs-2">
                        <span class="path1"></span>
                        <span class="path2"></span>
                        <span class="path3"></span>
                        <span class="path4"></span>
                      </i>
                      <span
                        id="kt_notification_unread_dot"
                        class="bullet bullet-dot bg-success h-6px w-6px position-absolute translate-middle top-0 start-50 animation-blink d-none"
                      ></span>
                    </div>
                    <!--end::Menu toggle-->
                    <!--begin::Menu-->
                    <div
                      class="menu menu-sub menu-sub-dropdown menu-column w-350px w-lg-375px"
                      data-kt-menu="true"
                      id="kt_menu_notifications"
                    >
                      <!--begin::Heading-->
                      <div
                        class="d-flex flex-column bgi-no-repeat rounded-top"
                        style="
                          background-image: url(&quot;assets/media/misc/menu-header-bg.jpg&quot;);
                        "
                      >
                        <!--begin::Title-->
                        <div class="d-flex flex-stack px-9 mt-10 mb-6">
                          <h3 class="text-white fw-semibold m-0">
                            Notifications
                          </h3>
                          <button
                            type="button"
                            id="kt_notification_mark_all_read"
                            class="btn btn-sm btn-color-white btn-active-color-primary"
                          >
                            Mark all as read
                          </button>
                        </div>
                        <!--end::Title-->
                      </div>
                      <!--end::Heading-->
                      <!--begin::Items-->
                      <style>
                        .notif-row {
                          display: grid;
                          grid-template-columns: 35px 1fr auto 12px;
                          align-items: center;
                          column-gap: 8px;
                        }
                      </style>
                      <div
                        class="scroll-y mh-325px my-5 px-8"
                        id="kt_notification_list"
                      >
                        <div class="text-muted text-center py-5">
                          No notifications
                        </div>
                      </div>
                      <!--end::Items-->
                      <!--begin::View more-->
                      <div class="py-3 text-center border-top">
                        <a
                          href="my_notification"
                          class="btn btn-color-gray-600 btn-active-color-primary"
                          >View All
                          <i class="ki-duotone ki-arrow-right fs-5"
                            ><span class="path1"></span>
                            <span class="path2"></span> </i
                        ></a>
                      </div>
                      <!--end::View more-->
                    </div>
                    <!--end::Menu-->
                  </div>
                  <!--end::Notifications-->

                  <a
                    href="my_notification"
                    class="btn btn-light-info d-inline-flex align-items-center px-6 py-3"
                    >My Notification</a
                  >
                </div>
              </div>
            </div>
          </div>
        </div>
        
         <div class="row mt-8">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header border-0 pt-6 align-items-start">
                                <div class="card-title">
                                    <h3 class="page-heading d-flex text-gray-900 fw-medium my-0">Cube Token</h3>
                                </div>
                            </div>
                            <div class="card-body">
                                <div class="d-flex flex-wrap gap-4">
	                                <a href="myCubeToken" class="btn btn-light-primary d-inline-flex align-items-center px-6 py-3">My Cube Token</a>
	                                <a href="tokenSettings" class="btn btn-light-info d-inline-flex align-items-center px-6 py-3">Cube Token Setting</a>
	                                <a href="cubeTokenManagement" class="btn btn-light-success d-inline-flex align-items-center px-6 py-3">Cube Token Management</a>
	                                <a href="privilegePage" class="btn btn-light-warning d-inline-flex align-items-center px-6 py-3">Privilege</a>
	                                <a href="privilegeMangementPage" class="btn btn-light-danger d-inline-flex align-items-center px-6 py-3">Privilege Management </a>
	                                <a href="cubeTokenRankingPage" class="btn btn-light-dark d-inline-flex align-items-center px-6 py-3">Cube Token Ranking</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
      </div>
    </div>
  </div>
</div>

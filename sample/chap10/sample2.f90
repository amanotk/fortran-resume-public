! GUI handler module
module gui_handler
  use gtk_hl
  use gtk, only: gtk_init, gtk_main, gtk_main_quit, gtk_container_add, &
       & gtk_widget_show_all
  implicit none

  type(c_ptr) :: window
  type(c_ptr) :: hbox, vbox
  type(c_ptr) :: btn_msg, btn_quit

contains
  ! show message dialog
  subroutine cb_msg(widget, gdata) bind(c)
    type(c_ptr), value :: widget, gdata

    integer(kind=c_int) :: response

    character(len=64) :: msg(4)

    msg(1) = "メッセージ"
    msg(2) = ""
    msg(3) = "好きなメッセージを"
    msg(4) = "ここに表示できます。"

    response = hl_gtk_message_dialog_show(msg, GTK_BUTTONS_OK, &
         & "メッセージダイアログ"//c_null_char, parent=window)
  call hl_gtk_box_pack(hbox, btn_msg, expand=FALSE)

  end subroutine cb_msg

  ! show dialog before quit
  subroutine cb_quit(widget, gdata) bind(c)
    type(c_ptr), value :: widget, gdata

    integer(kind=c_int) :: response

    character(len=40) :: msg(1)

    msg(1) = "本当に終了しますか?"

    response = hl_gtk_message_dialog_show(msg, GTK_BUTTONS_YES_NO, &
         & "終了"//c_null_char, parent=window)

    if (response == GTK_RESPONSE_YES) then
       call gtk_main_quit()
    end if

  end subroutine cb_quit
end module gui_handler

!
! main program
!
program sample
  use gui_handler
  implicit none

  ! init GUI
  call gtk_init()

  ! create main window
  window = hl_gtk_window_new("サンプル"//c_null_char, &
       & wsize=(/200, 200/), &
       & destroy=c_funloc(gtk_main_quit), &
       & border=10_c_int )

  ! verticall box
  vbox = hl_gtk_box_new(horizontal=FALSE, &
       & homogeneous=FALSE, &
       & spacing=10_c_int)
  call gtk_container_add(window, vbox)

  ! horizontal box in a vertical box
  hbox = hl_gtk_box_new(horizontal=TRUE, &
       & homogeneous=TRUE, &
       & spacing=10_c_int)
  call hl_gtk_box_pack(vbox, hbox, expand=FALSE, atend=TRUE)

  ! add button for a message dialog_
  btn_msg = hl_gtk_button_new("メッセージ"//c_null_char,&
       & clicked=c_funloc(cb_msg))
  call hl_gtk_box_pack(hbox, btn_msg, expand=FALSE)

  ! add button for quit
  btn_quit = hl_gtk_button_new("終了"//c_null_char,&
       & clicked=c_funloc(cb_quit))
  call hl_gtk_box_pack(hbox, btn_quit, expand=FALSE)


  ! now start app
  call gtk_widget_show_all(window)
  call gtk_main()

  stop
end program sample

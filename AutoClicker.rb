require 'ffi'

module User32
  extend FFI::Library
  ffi_lib 'user32'
  ffi_convention :stdcall

  attach_function :mouse_event, [:uint, :uint, :long, :long, :ulong, :ulong], :void
end

module AutoClicker
  extend FFI::Library
  ffi_lib FFI::Library::LIBC

  # Constants
  MOUSEEVENTF_LEFTDOWN = 0x0002
  MOUSEEVENTF_LEFTUP = 0x0004
end

def click(x, y)
  # Move the cursor to the specified coordinates
  User32.mouse_event(AutoClicker::MOUSEEVENTF_LEFTDOWN, x, y, 0, 0, 0)
  User32.mouse_event(AutoClicker::MOUSEEVENTF_LEFTUP, x, y, 0, 0, 0)
end

sleep(5)

# Example: Click at coordinates (500, 500) 10 times with a 1-second pause between clicks
1000.times do
  click(500, 500)
  sleep(0.000001)  # Pause for 1 second between clicks
end

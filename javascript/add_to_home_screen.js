function standalone() {
  if(window.navigator.standalone)
  {
}
  else {alert("Please add this page to your homescreen \(\+\)\ to view the custom icon, startup screen, and full screen mode.")}}
window.addEventListener("load",standalone, false)
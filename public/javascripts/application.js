var containerEl = document.querySelector(".container");

function readLess(event) {
  if (!event.target.parentElement.classList.contains("read-less")) { return; }
  event.target.parentElement.parentElement.style = "";
  event.target.parentElement.classList.add("read-more");
  event.target.parentElement.classList.remove("read-less");
  event.target.parentElement.innerHTML = '<a href="#" class="button">Read More</a>';
}

function readMore(event) {
  if (!event.target.parentElement.classList.contains("read-more")) { return; }
  event.target.parentElement.parentElement.style = "max-height: none";
  event.target.parentElement.classList.add("read-less");
  event.target.parentElement.classList.remove("read-more");
  event.target.parentElement.innerHTML = '<a href="#" class="button">Read Less</a>';
}

(function() {
  containerEl.addEventListener("click", readLess);
  containerEl.addEventListener("click", readMore);
})();

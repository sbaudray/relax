import socket from "./socket";

socket.connect();

function last(array) {
  return array[array.length - 1];
}

const { pathname } = window.location;

const topic = last(pathname.split("/"));

let channel = socket.channel(`room:${topic}`, {});

const messageInput = document.querySelector(".chat_message_input");
const messageList = document.querySelector(".chat_message_list");

channel
  .join()
  .receive("ok", resp => {
    console.log("Joined successfully", resp);
  })
  .receive("error", resp => {
    console.log("Unable to join", resp);
  });

channel.on("new_message", payload => {
  const { body } = payload;
  const listItem = document.createElement("li");
  listItem.innerText = body;
  messageList.appendChild(listItem);
});

messageInput.addEventListener("keydown", function handleKeyPress(event) {
  if (event.key === "Enter") {
    channel.push("new_message", { body: messageInput.value });
    messageInput.value = "";
  }
});

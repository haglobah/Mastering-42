let path = window.location.href;
if(path[path.length - 1] == "/") {
    path += "index.html";
}

let hiddenInputs = document.querySelectorAll("input");
hiddenInputs.forEach(link => {
    if(link.name == "link") {
        let val = link.value;
        link.value = path + val;
    }
});

let title = document.querySelector("h1");
if(title == null) {
    let filename = path.split("/");
    title = filename[filename.length - 1].split(".")[0];
}
else {
    title = title.textContent;
}

let forms = document.querySelectorAll(".sendEmail");
forms.forEach(form => {
    let textName = document.createElement("input");
    textName.type = "hidden";
    textName.name = "title";
    textName.value = title;
    form.appendChild(textName);
});
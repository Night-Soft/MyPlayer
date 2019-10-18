var i = 0;
var m = 0;
var strrr =("...");
var leng = 0;
var str = "";
var animReverse = false;

function searchEnabled() {
    i = 1;
    strrr.concat(strrr)
};
function searchDisabled() {
    i = 0;
};
function mPlus(){
    m++;

};
function shorteningTextElement(listMod, listVieww) {
    var inn = listVieww.currentIndex
    var ii = listMod.count;
    for (var sr = 0; sr <= ii; sr++  ){
        var str = new String (listMod.get(inn).nameFile);
        var ending = str.slice(str.length - 3, str.length);
        if (str.length > 45 && ending !== "..."){
            for(var i = str.length; i > 45; i--){
                str = str.slice(0, -1)
            }
            str = str.concat("...");
            listMod.insert(0, {"nameFile": str.toString(), "durationText": str.length.toString(), "textAboutFile": ii.toString()});
        }
    }


};
function shorteningTextAll(listMod, listVieww) {
    var inn = listVieww.currentIndex
    var ii = listMod.count;
    var sr = 0;
    var str = listMod.get(sr).nameFile;
    var ending = str.slice(str.length - 3, str.length);

    for (sr = 0; sr <= ii; sr++  ){
        str = listMod.get(1).nameFile;
        ending = str.slice(str.length - 3, str.length);
        if (str.length > 45 && ending !== "..."){
            for(var i = str.length; i > 45; i--){
                str = str.slice(0, -1)
            }
            str = str.concat("...");

            listMod.set(sr, {"nameFile": str.toString(), "durationText": str.length.toString(), "textAboutFile": "dfsddf"});
        }
    }


};
function enter(elementId) {
    elementId.width = 30
    elementId.height = 30
    elementId.x += 5
    elementId.y += 5
}
function exit(elementId) {
    elementId.width = 40
    elementId.height = 40
    elementId.x -= 5
    elementId.y -= 5

}
function runAnim(){
    if(textNameSong.contentWidth > textNameSong.width){
        animNameSong.start()
    } else {
    textNameSong.horizontalAlignment = Text.AlignCenter
    }
}
function runAnimDelay(){
    if(animReverse === false){
        runAnim()
        animReverse = true
    } else {
        animNameSongReverse.start()
        animReverse = false
    }
}
function AddNameFile(nameFilee){

}
 var testObject = {}
testObject.text = "0"
//button.setText("ok");
//var ts = testObject
function add(){
    //var amountElements = listView.count //= index
    listmodel.append({"nameFile": testObject.text.toString(), "durationText": "duration", "textAboutFile": "about", "sourceImage": "/resources/images/listIcon.svg"})

    listmodel.insert(0, {"nameFile": testObject.text.toString(), "durationText": "duration", "textAboutFile": "about", "sourceImage": "/resources/images/listIcon.svg"})
}
function newPlayList(listmodel){
    var countItem = listmodel.count
//    var deletedItem = listView.currentIndex = index

    while(countItem > 1){
        countItem--
        listmodel.remove(countItem)
    }
}
var getItemDel = [];
function callDeleteItem(getItemDelete){
    getItemDel += getItemDelete;
    //deleteItem(deleteItemArray);
}
function deleteItem(){
for (var i = 0; i <= getItemDel.length -1; i++){
    console.log(" delArray is " + getItemDel[i])
    listmodel.remove(getItemDel[i]);
    console.log(" i = " + i)
}
getItemDel = [];

}
//var myObject = new AddNameFile(list);
//myObject.sigAdd.connect(myObject, myObject.add);


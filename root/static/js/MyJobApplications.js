function getDestination () {
	var orderArray = ["JobTitle","Company","Applied"];
	var sortArray = ["Asc","Desc"];

	return orderArray [(document.getElementById('orderby').value) - 1] + '/' +
		   sortArray  [(document.getElementById('ascdesc').value) - 1];
}

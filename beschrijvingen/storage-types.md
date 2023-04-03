# Storage types
Er zijn verschillende types soorten bestand-opslag. Dit zijn de meest gebruikte in de Cloud.

## File
Dit is de meest bekende vorm van bestand-opslag. Dit is hoe je normaal je computer gebruik. File opslag is het opslaan van bestanden in een mappenstructuur. Je kan met NFS of SMB protocollen een file opslag op een ander computer benaderen.

Dit is een goede manier om bestanden te delen over een lokale netwerk.

## Block
Dit is de type opslag wat fysieke schijven gebruiken. Een schijf is opgedeeld in kleine blokjes schijfruimte. Die kan je dan opvullen met bestanden. Een filesystem is verantwoordelijk voor het bijhouden van de locaties van de blokken en in welke blokken welke bestanden zijn opgeslagen. Een bestand kan over meerdere blokken verdeeld worden.

## Object
Object storage slaat alle bestanden op als één enkel object met metadata. De metadata kan informatie bevatten van wie de eigenaar is. Je kan deze objecten benaderen met een REST api over HTTP. Dit maakt een goede type opslag om te gebruiken met het internet.

## Bronnen:
- https://cloudian.com/blog/object-storage-care/

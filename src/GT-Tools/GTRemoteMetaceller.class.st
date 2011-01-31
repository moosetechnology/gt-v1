"
self open
"
Class {
	#name : #GTRemoteMetaceller,
	#superclass : #GLMGlobalBrowserTemplate,
	#category : #'GT-Tools-Prototypes'
}

{ #category : #building }
GTRemoteMetaceller >> buildBrowser [
	browser := GLMTabulator new.
	browser title: 'Remote Metaceller'.
	browser column: #configs; column: #details.
	browser transmit to: #configs; andShow: [ :a | 
		a list 
			title: 'Remote configurations';
			format: #name;
			act: [:list | list selection version load ] entitled: 'Load configuration code' ].
	browser transmit to: #details; from: #configs; andShow: [ :a | 
		a list 
			title: 'Details';
			format: #selector;
			display: [:reference | reference version snapshot definitions select: [:each | 
					each isMethodDefinition and: [each classIsMeta not] ]];
			act: [:list | list selection inspect ] entitled: 'Inspect'].
	^ browser 
]

{ #category : #opening }
GTRemoteMetaceller >> entity [ 
	^ self remoteConfigurations
]

{ #category : #private }
GTRemoteMetaceller >> remoteConfigurations [
	| gofer packages |
	gofer := Gofer new
		disablePackageCache;
		squeaksource: 'MetacelloRepository';
		yourself.
	packages := Set new.
	gofer allResolved do: [ :each |
		| name |
		name := each packageName.
		((name beginsWith: 'ConfigurationOf') and: [ (packages includes: name) not ]) ifTrue: [
			packages add: name.
			gofer package: name ] ].
	^ gofer resolved
]

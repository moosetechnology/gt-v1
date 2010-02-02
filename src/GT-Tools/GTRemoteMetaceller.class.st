"
self open
"
Class {
	#name : #GTRemoteMetaceller,
	#superclass : #GLMGlobalBrowserTemplate,
	#category : #'GT-Tools'
}

{ #category : #building }
GTRemoteMetaceller >> buildBrowser [
	browser := GLMTabulator new.
	browser title: 'Remote Metaceller'.
	browser column: #configs; column: #details.
	browser transmit to: #configs; andShow: [:a | 
		a list ].
	browser transmit to: #details; from: #configs; andShow: [:a | 
		a list 
			display: [:reference | reference version snapshot definitions ]].
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

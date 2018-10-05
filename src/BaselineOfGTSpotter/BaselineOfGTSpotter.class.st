Class {
	#name : #BaselineOfGTSpotter,
	#superclass : #BaselineOf,
	#category : #BaselineOfGTSpotter
}

{ #category : #baselines }
BaselineOfGTSpotter >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec
			baseline: 'GlamourCore' with: [ 
				spec repository: 'github://moosetechnology/Glamour:pharo6/src' ]; 
			baseline: 'GTEventRecorder' with: [ 
				spec repository: 'github://moosetechnology/gt-v1:pharo6/src' ].
		spec 
			package: 'GT-Spotter' with: [
				spec requires: #('GlamourCore' ). ];
			package: 'GT-Spotter-EventRecorder' with: [
				spec requires: #('GT-Spotter' 'GTEventRecorder' ). ];
			package: 'GT-SpotterExtensions-Core' with: [
				spec requires: #('GT-Spotter' 'GlamourCore' ) ];
			package: 'GT-Tests-Spotter' with: [
				spec requires: #('GT-Spotter' 'GT-SpotterExtensions-Core' ) ] ]
]

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
			project: 'GlamourCore' with: [
				spec
					className: #ConfigurationOfGlamourCore;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/Moose/Glamour/main/' ].
		spec 
			baseline: 'GTEventRecorder' with: [ 
				spec repository: 'github://moosetechnology/gt-v1/src' ].
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

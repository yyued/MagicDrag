# MagicDrag

One day, I found Teambition App's launch introducing screen. Their animation shocks me.

I tried to write a similar features just like Teambition, but it's difficult.

Why not write a library including some basic animation, views animate with gesture triggers.

That's MagicDrag. No need to write much code, to create an unbelievable animating story.

## Preview

## How to works ?

MagicDrag use a scrollView which it's invisible. The scrollView content moves while user touch screen. We observes the scrollView delegate and deliver the contentOffset to Layers.

Layers including MGDPageLayer and MGDSceneLayer.

* MGDPageLayer similar to Photoshop's layer, it collects the same layerIndex MGDSceneLayer into one layer.
* MGDSceneLayer presents real content to user, you design animating views in it.

MGDSceneLayer can deliver contentOffset to MGDAnimatable view.

* MGDAnimatable is a protocol, views conforms this protocol can be animated.

## Usage

See Demo & Simple Start.

## Others

Library still in develop.

MIT License.

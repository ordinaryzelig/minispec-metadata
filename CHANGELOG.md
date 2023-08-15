## 3.5.0

* Use Minitest \_() syntax to get rid of deprecation warnings.

## 3.4

* Removed support for Ruby <2, Minitest <5.
* Convert remaining use of MiniTest to Minitest. (@manuelvanrijn)

## >3.2.1 <3.4

Lazily (not) documented here.

## 3.2.1

* Remove backwards compatibility for `__dir__`. (Thanks @brennovich for noticiing.)

## 3.2.0

* Add support for tags for command line filtering.

## 3.1.0

* Do not desctructively extract metadata from additional_desc.
* Use ALL additional_desc as metadata.

## 3.0.0

* Total rewrite.
* Fix bug with `it` clashing with `describe` when they were on the same level. (@jrochkind)
* Remove `spec_description`. Just use `self.class.desc`
* Rename `spec_descriptions` to `descs` (to try to stay close to Minitest naming) and moved it to the spec class level.
* Rename `spec_additional_description` to `additional_desc` (that's what Minitest calls it) and moved it to the spec class level.
* Rename `MiniSpec` to `Minispec`. The gem is named like it should be camel-cased this way.

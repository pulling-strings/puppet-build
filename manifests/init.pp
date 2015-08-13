# a module for managing build tools
class build {
  include build::lein
  include build::gradle
  include build::packer
  include build::sbt
}

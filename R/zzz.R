.onLoad <- function(libname, pkgname) {
  if (base::requireNamespace("webex", quietly = TRUE)) {
    warning("You have an outdated version of this package installed ('webex').\n",
            "To avoid problems, please uninstall the old version using:\n",
            "  remove.packages(\"webex\")")
  }
}

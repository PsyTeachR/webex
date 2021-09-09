.onLoad <- function(libname, pkgname) {
  if ("webex" %in% rownames(utils::installed.packages())) {
    warning("You have an outdated version of this package installed ('webex').\n",
            "To avoid problems, please uninstall the old version using:\n",
            "  remove.packages(\"webex\")")
  }
}

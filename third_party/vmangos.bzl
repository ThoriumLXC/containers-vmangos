"""
Dependency installation for the cmangos repositories.
"""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive", "http_file")

VMANGOS_CORE_COMMIT = "745988701e011c45170cd96861d8740925bd5279"

SOURCE_REF_LABELS = {
    # cmangos.net/vmangos-core
    "net.cmangos.vmangos-core.revision": VMANGOS_CORE_COMMIT,
    "net.cmangos.vmangos-core.source": "https://github.com/vmangos/core",
    "net.cmangos.vmangos-core.url": "https://github.com/vmangos/core",
    # cmangos.net/vmangos-database
    "net.cmangos.vmangos-database.revision": "2025-02-22",
    "net.cmangos.vmangos-database.source": "https://github.com/vmangos/database",
    "net.cmangos.vmangos-database.url": "https://github.com/vmangos/database",
}

def import_dependencies(name = "vmangos"):
    """Setup the archives to pull the git repositories for vmangos

    Args:
        name: A name prefix for all repositories.
    """

    http_archive(
        name = "{name}_core".format(name = name),
        url = "https://github.com/vmangos/core/archive/745988701e011c45170cd96861d8740925bd5279.tar.gz",
        strip_prefix = "core-745988701e011c45170cd96861d8740925bd5279",
        sha256 = "ef790fe1890882d9097fb693f9fa8a81d32eda06654240ab4ce669d85bccaf11",
        build_file = "//:third_party/vmangos_vmangos_core.BUILD",
    )

    http_archive(
        name = "{name}_database_world".format(name = name),
        url = "https://raw.githubusercontent.com/ThoriumLXC/vmangos-database/bbbf8da77b4a740c8fdac690742a1aecdf0a259c/world_full_14_june_2021.tar.xz",
        sha256 = "ae468ba1377564763d04caab7566f5da36008371c806353e86ef8a4334f6b003",
        build_file = "//:third_party/vmangos_database_world.BUILD",
    )

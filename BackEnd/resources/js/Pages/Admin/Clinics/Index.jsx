import AdminAuthenticatedLayout from "@/Layouts/AdminAuthenticatedLayout";
import { Head, router, Link } from "@inertiajs/react";
import styles from "./index.module.css";
export default function Index({ auth, clinics, queryParams = null, success }) {
    queryParams = queryParams || {};

    function sortByFun(name) {
        if (name == queryParams.sort_by) {
            if (queryParams.sort_dir == "asc") {
                queryParams.sort_dir = "desc";
            } else {
                queryParams.sort_dir = "asc";
            }
        } else {
            queryParams.sort_by = name;
            queryParams.sort_dir = "asc";
        }
        router.get(route("clinics.index"), queryParams);
    }

    function deleteclinic(clinic) {
        if (!window.confirm("Are you sure you want to delete the clinic?")) {
            return;
        }
        router.delete(route("clinics.destroy", clinic.id));
    }
    return (
        <AdminAuthenticatedLayout
            user={auth.user}
            header={
                <div className={styles.hheader}>
                    <h2 className="font-semibold text-xl text-gray-800 dark:text-gray-200 leading-tight">
                        Clinics
                    </h2>
                    <Link
                        href={route("clinics.create")}
                        className={styles.addnew}
                    >
                        Add new
                    </Link>
                </div>
            }
        >
            <Head title="clinics" />

            <div className="py-12">
                <div className="max-w-7xl mx-auto sm:px-6 lg:px-8">
                    <div className="bg-white dark:bg-gray-800 overflow-hidden shadow-sm sm:rounded-lg">
                        <div className="p-6 text-gray-900 dark:text-gray-100">
                            {success && (
                                <div className={styles.success}>{success}</div>
                            )}
                            <table className={styles.table}>
                                <thead className={styles.headtable}>
                                    <tr className={styles.tableheadtr}>
                                        <th
                                            onClick={(e) => sortByFun("id")}
                                            className={styles.tableht}
                                        >
                                            Id
                                        </th>
                                        <th className={styles.tableht}>
                                            Image
                                        </th>
                                        <th
                                            onClick={(e) => sortByFun("name")}
                                            className={styles.tableht}
                                        >
                                            Name
                                        </th>
                                        <th
                                            onClick={(e) => sortByFun("phone")}
                                            className={styles.tableht}
                                        >
                                            Phone no
                                        </th>
                                        <th
                                            onClick={(e) =>
                                                sortByFun("address")
                                            }
                                            className={styles.tableht}
                                        >
                                            Address
                                        </th>
                                        <th
                                            onClick={(e) =>
                                                sortByFun("created_at")
                                            }
                                            className={styles.tableht}
                                        >
                                            Created Date
                                        </th>
                                        <th
                                            onClick={(e) =>
                                                sortByFun("province_id")
                                            }
                                            className={styles.tableht}
                                        >
                                            City
                                        </th>

                                        <th className={styles.tableht}>
                                            Action
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {clinics.data.map((clinic) => (
                                        <tr>
                                            <td className={styles.tabletd}>
                                                {clinic.id}
                                            </td>
                                            <td className={styles.tabletd}>
                                                <img
                                                    src={clinic.image}
                                                    style={{
                                                        width: 60,
                                                        height: 60,
                                                    }}
                                                />
                                            </td>
                                            <td className={styles.tabletdname}>
                                                <Link
                                                    href={route(
                                                        "clinics.show",
                                                        clinic.id
                                                    )}
                                                >
                                                    {clinic.name}
                                                </Link>
                                            </td>
                                            <td className={styles.tabletd}>
                                                {clinic.phone}
                                            </td>
                                            <td className={styles.tabletd}>
                                                {clinic.address}
                                            </td>
                                            <td className={styles.tabletd}>
                                                {clinic.createdAt}
                                            </td>
                                            <td className={styles.tabletd}>
                                                {clinic.province}
                                            </td>

                                            <td>
                                                <button
                                                    className={
                                                        styles.deletelink
                                                    }
                                                    onClick={(e) =>
                                                        deleteclinic(clinic)
                                                    }
                                                >
                                                    Delete
                                                </button>
                                            </td>
                                        </tr>
                                    ))}
                                </tbody>
                            </table>
                            {/* <nav className="text-center mt-4">
                                {clinics.links.map((link) => (
                                    <Link
                                        dangerouslySetInnerHTML={{
                                            __html: link.label,
                                        }}
                                    ></Link>
                                ))}
                            </nav> */}
                            {/* {/* <Pagination links={clinics.links} /> */}
                        </div>
                    </div>
                </div>
            </div>
        </AdminAuthenticatedLayout>
    );
}

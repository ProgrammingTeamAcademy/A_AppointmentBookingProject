import AdminAuthenticatedLayout from "@/Layouts/AdminAuthenticatedLayout";
import { Head, router, Link } from "@inertiajs/react";
import styles from "./index.module.css";
export default function Index({ auth, doctors, queryParams = null, success }) {
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
        router.get(route("doctors.index"), queryParams);
    }
    return (
        <AdminAuthenticatedLayout
            user={auth.user}
            header={
                <div className={styles.hheader}>
                    <h2 className="font-semibold text-xl text-gray-800 dark:text-gray-200 leading-tight">
                        Doctors
                    </h2>
                    {/* <Link
                        href={route("doctors.create")}
                        className={styles.addnew}
                    >
                        Add new
                    </Link> */}
                </div>
            }
        >
            <Head title="doctors" />

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
                                            onClick={(e) => sortByFun("email")}
                                            className={styles.tableht}
                                        >
                                            Email
                                        </th>
                                        <th
                                            onClick={(e) => sortByFun("phone")}
                                            className={styles.tableht}
                                        >
                                            Phone no
                                        </th>
                                        <th
                                            onClick={(e) =>
                                                sortByFun("specialist")
                                            }
                                            className={styles.tableht}
                                        >
                                            Specialist
                                        </th>
                                        <th
                                            onClick={(e) =>
                                                sortByFun("about_doctor")
                                            }
                                            className={styles.tableht}
                                        >
                                            Description
                                        </th>
                                        <th
                                            onClick={(e) =>
                                                sortByFun("short_dscription")
                                            }
                                            className={styles.tableht}
                                        >
                                            Short des
                                        </th>
                                        <th
                                            onClick={(e) =>
                                                sortByFun("created_at")
                                            }
                                            className={styles.tableht}
                                        >
                                            Created Date
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {doctors.data.map((doctor) => (
                                        <tr>
                                            <td className={styles.tabletd}>
                                                {doctor.id}
                                            </td>
                                            <td className={styles.tabletd}>
                                                <img
                                                    src={doctor.image}
                                                    style={{
                                                        width: 60,
                                                        height: 60,
                                                    }}
                                                />
                                            </td>
                                            <td className={styles.tabletdname}>
                                                <Link
                                                    href={route(
                                                        "doctors.show",
                                                        doctor.id
                                                    )}
                                                >
                                                    {doctor.name}
                                                </Link>
                                            </td>
                                            <td className={styles.tabletd}>
                                                {doctor.email}
                                            </td>
                                            <td className={styles.tabletd}>
                                                {doctor.phone}
                                            </td>
                                            <td className={styles.tabletd}>
                                                {doctor.specialist}
                                            </td>
                                            <td className={styles.tabletd}>
                                                {doctor.about_doctor}
                                            </td>
                                            <td className={styles.tabletd}>
                                                {doctor.short_description}
                                            </td>
                                            <td className={styles.tabletd}>
                                                {doctor.createdAt}
                                            </td>
                                        </tr>
                                    ))}
                                </tbody>
                            </table>
                            {/* <nav className="text-center mt-4">
                                {doctors.links.map((link) => (
                                    <Link
                                        dangerouslySetInnerHTML={{
                                            __html: link.label,
                                        }}
                                    ></Link>
                                ))}
                            </nav> */}
                            {/* {/* <Pagination links={doctors.links} /> */}
                        </div>
                    </div>
                </div>
            </div>
        </AdminAuthenticatedLayout>
    );
}

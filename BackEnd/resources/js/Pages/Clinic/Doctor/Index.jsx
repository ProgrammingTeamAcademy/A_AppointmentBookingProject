import AuthenticatedLayout from "@/Layouts/ClinicAuthenticatedLayout";
import { Head, Link } from "@inertiajs/react";
import DoctorCard from "@/Components/doctorCard";
import styles from "./index.module.css";
export default function Index({ auth, doctors }) {
    return (
        <AuthenticatedLayout
            user={auth.user}
            header={
                <div className="flex justify-between">
                    <h2 className="font-semibold text-xl text-gray-800 dark:text-gray-200 leading-tight">
                        Doctors Page
                    </h2>
                    <Link href={route("cdoctor.create")} className={styles.new}>
                        New doctor
                    </Link>
                </div>
            }
        >
            <Head title="Clinic" />

            <div className="py-12">
                <div className="max-w-7xl mx-auto sm:px-6 lg:px-8">
                    <div className="bg-white dark:bg-gray-800 overflow-hidden shadow-sm sm:rounded-lg">
                        <div className="p-6 text-gray-900 dark:text-gray-100">
                            <div className="grid grid-cols-3 ">
                                {doctors.data.length > 0
                                    ? doctors.data.map((doctor) => (
                                          <DoctorCard doctor={doctor} />
                                      ))
                                    : "theres no doctors"}
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </AuthenticatedLayout>
    );
}

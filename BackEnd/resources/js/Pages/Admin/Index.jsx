import AdminAuthenticatedLayout from "@/Layouts/AdminAuthenticatedLayout";
import { Head } from "@inertiajs/react";

export default function Index({ auth, doctors, clinics }) {
    return (
        <AdminAuthenticatedLayout
            user={auth.user}
            header={
                <h2 className="font-semibold text-xl text-gray-800 dark:text-gray-200 leading-tight">
                    Admin panel
                </h2>
            }
        >
            <Head title="Admin-Dashboard" />
            <div className="py-12 grid grid-cols-3 ">
                <div className="max-w-7xl mx-auto sm:px-6 lg:px-8 w-11/12">
                    <div className="bg-white dark:bg-gray-800 overflow-hidden shadow-sm sm:rounded-lg">
                        <div className="p-6 text-gray-900 dark:text-gray-100 flex justify-between ">
                            <div>Total clinics</div>
                            <div>
                                {clinics.data.length} :{" "}
                                <a href={route("clinics.index")}> view all </a>
                            </div>
                        </div>
                        <div className="pb-2">
                            {clinics.data.slice(0, 3).map((clinic) => (
                                <div className="flex items-center mt-2 px-2 justify-between ">
                                    <div className="flex items-center">
                                        <img
                                            style={{
                                                width: 50,
                                                height: 50,
                                            }}
                                            src={clinic.image}
                                        />
                                        <div className="text-white ml-4 text-sm ">
                                            {clinic.name}
                                        </div>
                                    </div>
                                    <div className="text-white ml-4 text-sm ">
                                        {clinic.province}
                                    </div>
                                </div>
                            ))}
                        </div>
                    </div>
                </div>
                <div className="max-w-7xl mx-auto sm:px-6 lg:px-8  w-11/12">
                    <div className="bg-white dark:bg-gray-800 overflow-hidden shadow-sm sm:rounded-lg">
                        <div className="p-6 text-gray-900 dark:text-gray-100 flex justify-between ">
                            <div>Total doctors</div>
                            <div>
                                {doctors.data.length} :{" "}
                                <a href={route("doctors.index")}> view all </a>
                            </div>
                        </div>
                        <div className="pb-2">
                            {doctors.data.map((doctor) => (
                                <div className="flex justify-between items-center mt-2 px-2">
                                    <div className="flex items-center">
                                        <img
                                            style={{
                                                width: 50,
                                                height: 50,
                                            }}
                                            src={doctor.image}
                                        />
                                        <div className="text-white ml-4 text-sm text-nowrap">
                                            Dr. {doctor.name}
                                        </div>
                                    </div>
                                    <div className="text-white ml-4 text-xs text-nowrap">
                                        Specialist: {doctor.specialist}
                                    </div>
                                </div>
                            ))}
                        </div>
                    </div>
                </div>
                <div className="max-w-7xl mx-auto sm:px-6 lg:px-8  w-11/12">
                    <div className="bg-white dark:bg-gray-800 overflow-hidden shadow-sm sm:rounded-lg">
                        <div className="p-6 text-gray-900 dark:text-gray-100 flex justify-between ">
                            <div>Requests</div>
                            <div>
                                <a href={""}> view all </a>
                            </div>
                        </div>
                        <div className="pb-2"></div>
                    </div>
                </div>
            </div>
        </AdminAuthenticatedLayout>
    );
}

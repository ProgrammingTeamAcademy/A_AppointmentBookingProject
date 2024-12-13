import AuthenticatedLayout from "@/Layouts/ClinicAuthenticatedLayout";
import { Head, Link, useForm } from "@inertiajs/react";
import DoctorCard from "@/Components/doctorCard";
import styles from "./create.module.css";
import InputLabel from "@/Components/InputLabel";
import InputError from "@/Components/InputError";
import TextInput from "@/Components/TextInput";
import SelectInput from "@/Components/SelectInput";
import TextAreaInput from "@/Components/TextAreaInput";
export default function Create({ auth, specialist }) {
    const { data, setData, post, errors, reset } = useForm({
        image: "",
        name: "",
        phone: "",
        email: "",
        specialist: "",
        about: "",
    });

    const submitForm = (e) => {
        e.preventDefault();
        post(route("cdoctor.store"));
    };
    return (
        <AuthenticatedLayout
            user={auth.user}
            header={
                <h2 className="font-semibold text-xl text-gray-800 dark:text-gray-200 leading-tight">
                    New doctor
                </h2>
            }
        >
            <Head title="Create doctor" />

            <div className="py-12">
                <div className="max-w-7xl mx-auto sm:px-6 lg:px-8">
                    <div className="bg-white dark:bg-gray-800 overflow-hidden shadow-sm sm:rounded-lg">
                        <div className="p-6 text-gray-900 dark:text-gray-100">
                            <form onSubmit={submitForm} className={styles.form}>
                                {/* image */}
                                <div>
                                    <InputLabel
                                        htmlFor="doctor_image"
                                        value="Doctor image"
                                        className={styles.label}
                                    />
                                    <TextInput
                                        id="doctor_image"
                                        name="image"
                                        type="file"
                                        className={styles.txtInp}
                                        onChange={(e) =>
                                            setData("image", e.target.files[0])
                                        }
                                    />
                                    <InputError
                                        message={errors.image}
                                        className="mt-2"
                                    />
                                </div>
                                {/* Pname */}
                                <div className="mt-4">
                                    <InputLabel
                                        htmlFor="doctor_name"
                                        className={styles.label}
                                        value="Name"
                                    />

                                    <TextInput
                                        id="doctor_name"
                                        type="text"
                                        name="name"
                                        value={data.name}
                                        className={styles.txtInp}
                                        isFocused={true}
                                        onChange={(e) =>
                                            setData("name", e.target.value)
                                        }
                                    />

                                    <InputError
                                        message={errors.name}
                                        className="mt-2"
                                    />
                                </div>
                                {/* phone no */}
                                <div className="mt-4">
                                    <InputLabel
                                        className={styles.label}
                                        htmlFor="doctor_phone"
                                        value="Phone number"
                                    />

                                    <TextInput
                                        id="doctor_phone"
                                        type="text"
                                        name="phone"
                                        value={data.phone}
                                        className={styles.txtInp}
                                        onChange={(e) =>
                                            setData("phone", e.target.value)
                                        }
                                    />

                                    <InputError
                                        message={errors.phone}
                                        className="mt-2"
                                    />
                                </div>
                                {/* email */}
                                <div className="mt-4">
                                    <InputLabel
                                        className={styles.label}
                                        htmlFor="doctor_email"
                                        value="Email address"
                                    />

                                    <TextInput
                                        id="doctor_email"
                                        type="email"
                                        name="email"
                                        value={data.email}
                                        className={styles.txtInp}
                                        onChange={(e) =>
                                            setData("email", e.target.value)
                                        }
                                    />

                                    <InputError
                                        message={errors.email}
                                        className="mt-2"
                                    />
                                </div>

                                {/* specialist */}
                                <div className="mt-4">
                                    <InputLabel
                                        className={styles.label}
                                        htmlFor="doctor_specialist"
                                        value="Specialist"
                                    />
                                    <SelectInput
                                        id="doctor_specialist"
                                        name="specialist"
                                        className={styles.txtInp}
                                        onChange={(e) =>
                                            setData(
                                                "specialist",
                                                e.target.value
                                            )
                                        }
                                    >
                                        <option value="">
                                            Select specialist
                                        </option>
                                        {specialist.data.map((specialist) => (
                                            <option
                                                value={specialist.id}
                                                key={specialist.id}
                                                className={styles.options}
                                            >
                                                {specialist.name}
                                            </option>
                                        ))}
                                    </SelectInput>
                                    <InputError
                                        message={errors.specialist}
                                        className="mt-2"
                                    />
                                </div>

                                {/* about */}
                                <div className="mt-4">
                                    <InputLabel
                                        className={styles.label}
                                        htmlFor="doctor_about"
                                        value="Description"
                                    />

                                    <TextAreaInput
                                        id="doctor_about"
                                        type="text"
                                        name="about"
                                        value={data.about}
                                        className={styles.txtInp}
                                        onChange={(e) =>
                                            setData("about", e.target.value)
                                        }
                                    />

                                    <InputError
                                        message={errors.about}
                                        className="mt-2"
                                    />
                                </div>

                                <div className={styles.btns}>
                                    <Link
                                        href={route("cdoctor.index")}
                                        className={styles.cancel}
                                    >
                                        Cancel
                                    </Link>
                                    <button className={styles.submit}>
                                        Submit
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </AuthenticatedLayout>
    );
}

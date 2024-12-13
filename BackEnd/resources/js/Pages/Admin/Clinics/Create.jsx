import AdminAuthenticatedLayout from "@/Layouts/AdminAuthenticatedLayout";
import { Head, Link, router, useForm } from "@inertiajs/react";
import styles from "./create.module.css";
import InputLabel from "@/Components/InputLabel";
import TextInput from "@/Components/TextInput";
import InputError from "@/Components/InputError";
import SelectInput from "@/Components/SelectInput";
import TextAreaInput from "@/Components/TextAreaInput";
import "react-country-state-city/dist/react-country-state-city.css";

export default function Create({ auth, countries, provinces }) {
    const { data, setData, post, errors, reset } = useForm({
        image: "",
        name: "",
        address: "",
        phone: "",
        province_id: "",
        country: "",
        about: "",
    });

    const submitForm = (e) => {
        e.preventDefault();
        post(route("clinics.store"));
    };
    return (
        <AdminAuthenticatedLayout
            user={auth.user}
            header={
                <div className={styles.hheader}>
                    <h2 className="font-semibold text-xl text-gray-800 dark:text-gray-200 leading-tight">
                        Create new clinic
                    </h2>
                </div>
            }
        >
            <Head title="New Clinic" />

            <div className="py-12">
                <div className="max-w-7xl mx-auto sm:px-6 lg:px-8">
                    <div className="bg-white dark:bg-gray-800 overflow-hidden shadow-sm sm:rounded-lg">
                        <div className="p-6 text-gray-900 dark:text-gray-100">
                            <form
                                onSubmit={submitForm}
                                className="p-4 sm:p-8 bg-white dark:bg-gray-800 shadow sm:rounded-lg"
                            >
                                {/* image */}
                                <div>
                                    <InputLabel
                                        htmlFor="clinic_iamge"
                                        value="Clinic image"
                                    />
                                    <TextInput
                                        id="clinic_iamge"
                                        name="image"
                                        type="file"
                                        className="mt-1 block w-full"
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
                                        htmlFor="clinic_name"
                                        value="Clinic Name"
                                    />

                                    <TextInput
                                        id="clinic_name"
                                        type="text"
                                        name="name"
                                        value={data.name}
                                        className="mt-1 block w-full"
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
                                {/* about */}
                                <div className="mt-4">
                                    <InputLabel
                                        htmlFor="clinic_about"
                                        value="Description"
                                    />

                                    <TextAreaInput
                                        id="clinic_about"
                                        type="text"
                                        name="about"
                                        value={data.about}
                                        className="mt-1 block w-full"
                                        onChange={(e) =>
                                            setData("about", e.target.value)
                                        }
                                    />

                                    <InputError
                                        message={errors.about}
                                        className="mt-2"
                                    />
                                </div>
                                {/* phone no */}
                                <div className="mt-4">
                                    <InputLabel
                                        htmlFor="clinic_phone"
                                        value="Clinic phone no"
                                    />

                                    <TextInput
                                        id="clinic_phone"
                                        type="text"
                                        name="phone"
                                        value={data.phone}
                                        className="mt-1 block w-full"
                                        onChange={(e) =>
                                            setData("phone", e.target.value)
                                        }
                                    />

                                    <InputError
                                        message={errors.phone}
                                        className="mt-2"
                                    />
                                </div>

                                {/* country */}
                                <div className="mt-4">
                                    <InputLabel
                                        htmlFor="clinic_country"
                                        value="Country"
                                    />
                                    <SelectInput
                                        id="clinic_country"
                                        name="country"
                                        className="mt-1 block w-full"
                                        onChange={(e) =>
                                            setData("country", e.target.value)
                                        }
                                    >
                                        <option value="">Select country</option>
                                        {countries.data.map((country) => (
                                            <option
                                                value={country.id}
                                                key={country.id}
                                            >
                                                {country.country_name}
                                            </option>
                                        ))}
                                    </SelectInput>
                                    <InputError
                                        message={errors.country}
                                        className="mt-2"
                                    />
                                </div>
                                {/* province */}
                                <div className="mt-4">
                                    <InputLabel
                                        htmlFor="clinic_province"
                                        value="Province"
                                    />
                                    <SelectInput
                                        id="clinic_province"
                                        name="province"
                                        className="mt-1 block w-full"
                                        onChange={(e) =>
                                            setData(
                                                "province_id",
                                                e.target.value
                                            )
                                        }
                                    >
                                        <option value="">
                                            Select province
                                        </option>
                                        {provinces.data.map((province) => {
                                            if (
                                                province.country_id ==
                                                data.country
                                            ) {
                                                return (
                                                    <option
                                                        value={province.id}
                                                        key={province.id}
                                                    >
                                                        {province.province}
                                                    </option>
                                                );
                                            }
                                        })}
                                    </SelectInput>
                                    <InputError
                                        message={errors.province}
                                        className="mt-2"
                                    />
                                </div>
                                {/* address */}
                                <div className="mt-4">
                                    <InputLabel
                                        htmlFor="clinic_address"
                                        value="Address"
                                    />
                                    <TextInput
                                        id="clinic_address"
                                        type="text"
                                        name="address"
                                        value={data.address}
                                        className="mt-1 block w-full"
                                        onChange={(e) =>
                                            setData("address", e.target.value)
                                        }
                                    />
                                    <InputError
                                        message={errors.address}
                                        className="mt-2"
                                    />
                                </div>

                                <div className={styles.btns}>
                                    <Link
                                        href={route("clinics.index")}
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
        </AdminAuthenticatedLayout>
    );
}

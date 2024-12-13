import React, { useState, useMemo } from "react";
import SelectInput from "@/Components/SelectInput";
import {
    CitySelect,
    CountrySelect,
    StateSelect,
    LanguageSelect,
} from "react-country-state-city";
import "react-country-state-city/dist/react-country-state-city.css";

export default function Index() {
    const [countryid, setCountryid] = useState(0);
    const [stateid, setstateid] = useState(0);

    return (
        <div>
            <h6>Country</h6>
            <CountrySelect
                onChange={(e) => {
                    setCountryid(e.id);
                }}
                placeHolder="Select Country"
            />
            <h6>State</h6>
            <StateSelect
                countryid={countryid}
                onChange={(e) => {
                    setstateid(e.id);
                }}
                placeHolder="Select State"
            />
            <h6>City</h6>
            <CitySelect
                countryid={countryid}
                stateid={stateid}
                onChange={(e) => {
                    console.log(e);
                }}
                placeHolder="Select City"
            />
            <h6>Language</h6>
            <LanguageSelect
                onChange={(e) => {
                    console.log(e);
                }}
                placeHolder="Select Language"
            />
        </div>
    );
    return (
        <>
            <pre>{JSON.stringify(options)}</pre>
            <SelectInput
                id="clinic_country"
                name="country"
                className="mt-1 block w-full"
                onChange={(e) => setData("country", e.target.value)}
            >
                <option value="">Select country</option>
                {options.map((country) => (
                    <option value={country.value} key={country.value}>
                        {country.label}
                    </option>
                ))}
            </SelectInput>
        </>
    );

    <Select options={options} value={value} onChange={changeHandler} />;
}
